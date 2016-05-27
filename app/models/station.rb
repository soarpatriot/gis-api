class Station < ActiveRecord::Base

  has_many :points, as: :pointable, dependent: :destroy
  has_many :areas, ->{where atype: 0}, dependent: :destroy
  has_many :delivery_areas, -> { where atype: 1  } , :class_name => 'Area', dependent: :destroy 
  belongs_to :stationable, polymorphic: true
  
end
