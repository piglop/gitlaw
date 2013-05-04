class Text < ActiveRecord::Base
  attr_accessible :text, :title, :base_id
  
  belongs_to :base, class_name: "Text"
  belongs_to :user, inverse_of: :texts
  
  has_many :modifications, inverse_of: :original, foreign_key: :original_id
  
  after_validation :clean_text
  
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  def clean_text
    self.text = self.text.gsub("\r\n", "\n") if self.text
  end
end
