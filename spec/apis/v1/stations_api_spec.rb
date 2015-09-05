require "spec_helper"

describe V1::StationsApi do

  let(:stations_path) { "/v1/stations" }
  let(:nopoints_stations_path) { "/v1/stations/nopoints" }
  let(:city_stations_path) { "/v1/stations/city" }
  
  def one_stations_path station
    "/v1/stations/#{station.id}"
  end

  def station_area_path station 
    "/v1/stations/#{station.id}/areas"
  end
  
  context "station area" do 
    it "get areas" do 
      points = create_list :point, 10
      points1 = create_list :point, 5
      area1 = create :area, points: points 
      area2 = create :area, points: points1 

      areas = [area1,area2]
      station = create :station, areas: areas 

      res = json_get station_area_path(station)
      expect(res.size).to eq(2)

    end
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

  context "delete statsion" do 
    it "success" do 

      points = create_list :point, 3
      points1 = create_list :point,4 
      points2 = create_list :point,5 

      area = create :area, points: points 
      area1 = create :area, points: points2 
      areas = [area,area1] 
      station = create :station, areas: areas, points: points1 

      res = data_delete one_stations_path(station), id: station.id 
      expect(Area.all.size).to eq(0)
      expect(Point.all.size).to eq(0)
      expect(Station.all.size).to eq(0)

    end
  end 


end
