class City < ActiveRecord::Base

  has_many :counties
  belongs_to :province
  has_many :stations, as: :stationable 

end
