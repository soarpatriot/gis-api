
require "spec_helper"

RSpec.describe Area, :type => :model do 
  context "points in area" do 
     it "in" do 

       test_point = Hash.new 
       test_point[:lantitude] = 40.0521
       test_point[:longitude] = 116.305
       test_point2 = Hash.new 
       test_point2[:lantitude] = 40.0536
       test_point2[:longitude] = 116.297
       test_point3 = Hash.new 
       test_point3[:lantitude] = 40.046897
       test_point3[:longitude] = 116.299642

       test_point4 = Hash.new 
       test_point4[:lantitude] = 40.047504
       test_point4[:longitude] = 116.295905
       test_point5 = Hash.new 
       test_point5[:lantitude] = 40.04535
       test_point5[:longitude] = 116.301294




       point1 = create :point, lantitude: 40.0536, longitude: 116.297
       point2 = create :point, lantitude: 40.0497, longitude: 116.298 
       point3 = create :point, lantitude: 40.0464, longitude: 116.303 
       point4 = create :point, lantitude: 40.0475, longitude: 116.311 
       point5 = create :point, lantitude: 40.0511, longitude: 116.311 
       point6 = create :point, lantitude: 40.0547, longitude: 116.308 
       point7 = create :point, lantitude: 40.055, longitude: 116.307 

       points = [point1,point2,point3,point4,point5,point6,point7]
       area = create :area, points: points  

       at_area = area.in? test_point
       
       expect(at_area).to eq(true)
       at_area = area.in? test_point2
       expect(at_area).to eq(true)

       at_area = area.in? test_point3
       expect(at_area).to eq(false)
       at_area = area.in? test_point4
       expect(at_area).to eq(false)
       at_area = area.in? test_point5
       expect(at_area).to eq(false)
 
     end
  end 
end
