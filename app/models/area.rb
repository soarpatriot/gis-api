class Area < ActiveRecord::Base
  
  has_many :points, as: :pointable

end
