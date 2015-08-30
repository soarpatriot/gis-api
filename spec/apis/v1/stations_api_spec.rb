require "spec_helper"

describe V1::StationsApi do

  let(:find_station_path) { "/v1/station/login" }
  let(:register_path) { "/v1/user/register" }
  let(:update_profile_path) { "/v1/user/update_profile" }
  
  def one_stations_path station
    "/v1/stations/#{station.id}"
  end

  context "get on station" do

    it "succes" do
      station = create :station
      res = json_get one_stations_path(station) 
      binding.pry
      # expect(res[:name]).to eq("aaa")
    end

  end
  
end
