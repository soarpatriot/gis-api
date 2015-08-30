class City < ActiveRecord::Base

  has_many :counties
  has_many :stations  
end
