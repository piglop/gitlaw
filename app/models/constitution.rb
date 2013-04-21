class Constitution < ActiveRecord::Base
  attr_accessible :text, :title, :base_id
  
  belongs_to :base, class_name: "Constitution"
end
