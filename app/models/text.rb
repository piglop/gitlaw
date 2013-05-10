class Text < ActiveRecord::Base
  attr_accessible :text, :title, :base_id, :slug, :modifications_attributes
  
  belongs_to :base, class_name: "Text"
  belongs_to :user, inverse_of: :texts
  
  has_many :modifications, inverse_of: :repository, foreign_key: :repository_id
  accepts_nested_attributes_for :modifications
  
  validates_presence_of :user
  after_validation :clean_text
  
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :user
  
  def clean_text
    self.text = self.text.gsub("\r\n", "\n") if self.text
  end
  
  before_save :commit_text
  
  def repository_path
    raise "User is required" unless user
    raise "User.to_param is required" unless user.to_param.present?
    raise "to_param is required" unless to_param.present?
    Rails.root.join("db", "repositories", Rails.env, user.to_param, to_param + ".git")
  end
  
  def create_repository
    if base
      # Move to Rugged when https://github.com/libgit2/rugged/pull/107 is merged
      system "git", "clone", base.repository_path.to_s, repository_path.to_s
    else
      Rugged::Repository.init_at(repository_path.to_s, true)
    end
  end
  
  def commit_text
    create_repository unless repository_path.exist?
    
    return if text.blank?
    
    repo = Rugged::Repository.new(repository_path.to_s)
    
    oid = repo.write(self.text, :blob)
    index = Rugged::Index.new
    index.add(:path => "#{title}.txt", :oid => oid, :mode => 0100644)

    options = {}
    options[:tree] = index.write_tree(repo)

    options[:author] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:committer] = { :email => "testuser@github.com", :name => 'Test Author', :time => Time.now }
    options[:message] ||= "Making a commit via Rugged!"
    
    ref = Rugged::Reference.lookup(repo, "refs/heads/master")
    if ref
      options[:parents] = [ref.target]
    else
      options[:parents] = []
    end

    new_sha1 = Rugged::Commit.create(repo, options)
    
    if ref
      ref.set_target(new_sha1)
    else
      ref = Rugged::Reference.create(repo, "refs/heads/master", new_sha1)
    end
    
    self.head = new_sha1
    
  end
  
  def master
    modifications.detect(&:master?)
  end
end
