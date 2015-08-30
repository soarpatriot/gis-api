class County < ActiveRecord::Base
  has_many :stations, as: :stationable
end
