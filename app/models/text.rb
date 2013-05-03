class Text < ActiveRecord::Base
  attr_accessible :text, :title, :base_id
  
  belongs_to :base, class_name: "Text"
  belongs_to :user, inverse_of: :texts
  
  has_many :children, class_name: "Text", foreign_key: "base_id", inverse_of: :base
  
  after_validation :clean_text
  
  extend FriendlyId
  friendly_id :title, use: :scoped, scope: :user
  
  def clean_text
    self.text = self.text.gsub("\r\n", "\n") if self.text
  end
  
  after_create :create_repository
  
  def repository_path
    raise "User is required" unless user
    raise "User.to_param is required" unless user.to_param.present?
    raise "to_param is required" unless to_param.present?
    Rails.root.join("db", "repositories", Rails.env, user.to_param, to_param + ".git")
  end
  
  def create_repository
    Rugged::Repository.init_at(repository_path.to_s, true)
  end
end
