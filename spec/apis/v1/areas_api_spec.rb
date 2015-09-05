require "spec_helper"

describe V1::AreasApi do

  let(:areas_path) { "/v1/areas" }
 
  def update_area_path area 
    "v1/areas/#{area.id}"
  end 
 
  context "create area" do 
    it "success" do
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]
      label = "aa"
      station = create :station 
      res = json_post areas_path, label:label, points: points, station_id: station.id 
      expect(res[:label]).to eq(label)
      expect(res[:points].size).to eq(2)
    end
  end
  context "update area" do 
    it "success" do
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]
      label = "aa"
      
      points2 = create_list :point, 5
      station = create :station 
      area = create :area, station:station, points: points2, label: "abc"
      res = json_put update_area_path(area), label:label, points: points, station_id: station.id 
      expect(res[:label]).to eq(label)
      expect(res[:points].size).to eq(2)
    end
  end
  context "delete area" do 
    it "success" do
      
      points2 = create_list :point, 5
      station = create :station 
      area = create :area, station:station, points: points2, label: "abc"
      res = data_delete update_area_path(area), id: area.id 
      expect(Point.all.size).to eq(0)
    end
  end




end
