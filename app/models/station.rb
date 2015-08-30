class Station < ActiveRecord::Base

  has_many :points, as: :pointable
  has_many :areas
  
end
