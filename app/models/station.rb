class Station < ActiveRecord::Base

  has_many :points, as: :pointable, dependent: :destroy
  has_many :areas, dependent: :destroy

  belongs_to :stationable, polymorphic: true
  
end
