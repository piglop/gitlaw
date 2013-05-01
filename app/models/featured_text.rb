class FeaturedText < ActiveRecord::Base
  belongs_to :text
  # attr_accessible :title, :body
end
