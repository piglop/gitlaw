class FeaturedConstitution < ActiveRecord::Base
  belongs_to :constitution
  # attr_accessible :title, :body
end
