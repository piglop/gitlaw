class Modification < ActiveRecord::Base
  attr_accessible :motivations, :text, :title, :original_id
  
  belongs_to :user
  belongs_to :original, class_name: "Text"
  belongs_to :repository, class_name: "Text"

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :user
  
  before_save :create_repository
  after_save :commit_text
  
  def create_repository
    return if repository
    
    raise "Original required" unless original
    raise "User required" unless user
    repository = build_repository(title: original.title, slug: original.slug)
    repository.user = user
    repository.save!
  end

  def commit_text
    return if text.blank?
    
    repo = Rugged::Repository.new(repository.repository_path.to_s)
    
    oid = repo.write(self.text, :blob)
    index = Rugged::Index.new
    index.add(:path => "#{original.title}.txt", :oid => oid, :mode => 0100644)

    options = {}
    options[:tree] = index.write_tree(repo)

    options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:message] ||= "Making a commit via Rugged!"
    
    ref_path = "refs/heads/#{slug}"
    ref = Rugged::Reference.lookup(repo, ref_path)
    if ref
      options[:parents] = [ref.target]
    else
      options[:parents] = []
    end

    new_sha1 = Rugged::Commit.create(repo, options)
    
    if ref
      ref.set_target(new_sha1)
    else
      ref = Rugged::Reference.create(repo, ref_path, new_sha1)
    end
  end
end
