require "spec_helper"

describe V1::StationsApi do

  let(:stations_path) { "/v1/stations" }
  let(:nopoints_stations_path) { "/v1/stations/nopoints" }
  let(:city_stations_path) { "/v1/stations/city" }
  
  def one_stations_path station
    "/v1/stations/#{station.id}"
  end
  
  context "city stations" do 
    it "succes" do
      description = "cca"
      stations = []
      points = create_list :point, 5 
      points1 = create_list :point, 5 
      station = create :station,description:description,  points: points 
      station1 = create :station,description:description,  points: points1 
   
      stations << station
      stations << station1
      city = create :city, stations: stations
      res = json_get city_stations_path, city_id: city.id 
      expect(res.size).to eq(2)
    end
    it "nopoints" do 
      description = "cca"
      stations = []
      points = create_list :point, 5 
      points1 = create_list :point, 5 
      station = create :station,description:description  
      station1 = create :station,description:description,  points: points1 
   
      stations << station
      stations << station1
      city = create :city, stations: stations
      res = json_get nopoints_stations_path, city_id: city.id 
      binding.pry
      expect(res.size).to eq(1)

    end

  end
  context "get on station" do

    it "succes" do
      description = "cca"
      points = create_list :point, 5 
      station = create :station,description:description,  points: points 
      res = json_get one_stations_path(station) 
      expect(res[:points].size).to eq(5)
      expect(res[:description]).to eq(description)
    end

  end

  context "create statsion" do 
    it "success" do 
      description = "aaa"
      address ="bb"      
      lan = 12.03      
      long = 12.05      
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]
      res = json_post stations_path, description: description, address: address, lantitude: lan, longitude: long, points: points
      
      expect(res[:description]).to eq(description)
      expect(res[:lantitude]).to eq(lan)

    end
  end 

  context "update station" do 
    it "success update all" do 
      description = "aaa"
      address ="bb"      
      lan = 12.03      
      long = 12.05      
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]

      ps = create_list :point, 5
      station = create :station, description: "sss", address: "s23", points: ps 

      res = json_put one_stations_path(station), description: description, address: address, lantitude: lan, longitude: long, points: points
      expect(res[:points].size).to eq(2)
      expect(res[:description]).to eq(description)
      expect(res[:lantitude]).to eq(lan)

    end

    it "update description" do 
      description = "aaa"
      address ="bb"      
      lan = 12.03      
      long = 12.05      
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]

      ps = create_list :point, 5
      station = create :station, description: "sss", address: "s23", points: ps 

      res = json_put one_stations_path(station), description: description
      expect(res[:points].size).to eq(5)
      expect(res[:description]).to eq(description)

    end
 
  end
end
