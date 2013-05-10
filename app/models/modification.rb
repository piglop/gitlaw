class Modification < ActiveRecord::Base
  attr_accessible :motivations, :text, :title, :original_id
  
  belongs_to :user
  belongs_to :original, class_name: "Text"
  belongs_to :repository, class_name: "Text"

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates_presence_of :user
  
  before_save :create_repository
  
  def create_repository
    return if repository
    
    raise "Original required" unless original
    raise "User required" unless user
    repository = build_repository(title: original.title, slug: original.slug)
    repository.user = user
    repository.save!
  end
end
