require "spec_helper"

describe V1::CitiesApi do

  let(:cities_path) { "/v1/citiess" }
 
  def city_districts_path city 
    "v1/cities/#{city.id}/districts"
  end 
  def city_stations_path city 
    "v1/cities/#{city.id}/stations"
  end 
 
  context "get districts area" do
    it "one" do 
      districts = create_list :district, 10
      city = create :city, districts: districts 
      res = auth_json_get city_districts_path(city)
      expect(res.size).to eq(10)
    end
  end 
  context "get city stations" do
    it "one" do 
      city = create :city
      stations = create_list :station, 10, stationable: city
      res = auth_json_get city_stations_path(city)
      expect(res.size).to eq(10)
    end
  end 

end
