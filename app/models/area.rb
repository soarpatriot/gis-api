class Area < ActiveRecord::Base
  
  belongs_to :station
  has_many :points, as: :pointable

end
