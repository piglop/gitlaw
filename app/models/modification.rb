class Modification < ActiveRecord::Base
  attr_accessible :description, :text, :title, :original_id
  
  belongs_to :original, class_name: "Modification"
  belongs_to :repository, class_name: "Text"
  
  delegate :user, to: :repository

  before_save :commit_text
  
  extend FriendlyId
  friendly_id :slug_base, use: [:slugged, :scoped], scope: :repository

  def slug_base
    title.presence || "master"
  end
  
  def create_repository(user)
    return if repository
    
    raise "Original required" unless original
    raise "User required" unless user
    self.repository = user.texts.where(slug: original.repository.slug).first_or_initialize(title: original.repository.title)
    self.repository.user = user
    self.repository.save!
  end

  def commit_text
    return if text.blank?
    
    repo = Rugged::Repository.new(repository.repository_path.to_s)
    
    oid = repo.write(self.text, :blob)
    index = Rugged::Index.new
    index.add(:path => "#{repository.title}.txt", :oid => oid, :mode => 0100644)

    options = {}
    options[:tree] = index.write_tree(repo)

    options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:message] ||= "Making a commit via Rugged!"

    if head
      options[:parents] = [head]
    elsif original
      options[:parents] = [original.head]
      
      unless repo.exists?(original.head)
        original_repository = Rugged::Repository.new(original.repository.repository_path.to_s)
        walker = Rugged::Walker.new(original_repository)
        walker.sorting(Rugged::SORT_TOPO | Rugged::SORT_REVERSE)
        walker.push(original.head)
        walker.each do |commit|
          break if repo.exists?(commit.oid)
          new_commit = commit.to_hash
          
          builder = Rugged::Tree::Builder.new
          commit.tree.each do |entry|
            unless repo.exists?(entry[:oid])
              obj = original_repository.read(entry[:oid])
              repo.write(obj.data, obj.type)
            end
            builder << entry
          end
          new_commit[:tree] = builder.write(repo)
          new_commit[:parents] = new_commit[:parents].map(&:oid)
          
          Rugged::Commit.create(repo, new_commit)
        end
      end
    else
      options[:parents] = []
    end

    new_sha1 = Rugged::Commit.create(repo, options)
    
    branch = slug
    ref_path = "refs/heads/#{branch}"
    ref = Rugged::Reference.lookup(repo, ref_path)
    if ref
      ref.set_target(new_sha1)
    else
      ref = Rugged::Reference.create(repo, ref_path, new_sha1)
    end
    
    self.head = new_sha1
  end
  
  def master?
    slug == "master"
  end
end
