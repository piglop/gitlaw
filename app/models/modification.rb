class Modification < ActiveRecord::Base
  attr_accessible :motivations, :text, :title, :original_id
  
  belongs_to :user
  belongs_to :original, class_name: "Text"

  extend FriendlyId
  friendly_id :title, use: :slugged
end
