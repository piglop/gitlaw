class Modification < ActiveRecord::Base
  belongs_to :user
  belongs_to :original
  attr_accessible :motivations, :text, :title
end
