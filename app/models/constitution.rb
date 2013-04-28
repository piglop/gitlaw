class Constitution < ActiveRecord::Base
  attr_accessible :text, :title, :base_id
  
  belongs_to :base, class_name: "Constitution"
  belongs_to :user, inverse_of: :constitutions
  
  after_validation :clean_text
  
  
  def clean_text
    self.text = self.text.gsub("\r\n", "\n") if self.text
  end
end
