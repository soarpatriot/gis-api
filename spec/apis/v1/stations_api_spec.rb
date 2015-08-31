require "spec_helper"

describe V1::StationsApi do

  let(:stations_path) { "/v1/stations" }
  
  def one_stations_path station
    "/v1/stations/#{station.id}"
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
