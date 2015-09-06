class Province < ActiveRecord::Base
  has_many :cities

  has_many :stations, through: :cities
end
