require "spec_helper"

describe V1::AreasApi do

  let(:areas_path) { "/v1/areas" }
  let(:areas_commission_path) { "/v1/areas/commission" }
  let(:area_name_exist_path) { "/v1/areas/name-exist" }
   
  def update_area_path area 
    "v1/areas/#{area.id}"
  end 
 
  context "create area" do 
    it "success" do
      commission = create :commission 
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]
      label = "aa"
      code = "cc" 
      latitude = 12.4
      longitude = 23.5667
      distance = 345
      mian = 23452345.12 
      station = create :station 

      res = auth_json_post areas_path, label:label, points: points, station_id: station.id, commission_id: commission.id, code: code, latitude: latitude, longitude: longitude, distance: distance, mian: mian

      expect(res[:commission_id]).to eq(commission.id)
      expect(res[:label]).to eq(label)
      expect(res[:points].size).to eq(2)
      expect(res[:code]).to eq(code)
      expect(res[:mian]).to eq(mian.to_s)
      expect(res[:distance]).to eq(distance)
      expect(res[:latitude]).to eq(latitude.to_s)
      expect(res[:longitude]).to eq(longitude.to_s)
 
    end
  end
  context "name exist"  do 
    it "create check" do 
      station = create :station 
      area = create :area, station: station, label: "aaaa"
      name = "a1"
      res  = auth_json_get area_name_exist_path, name: name, station_id: station.id
      expect(res[:status]).to eq(0)
      
    end
    it "update check" do 
      station = create :station 
      area = create :area, station: station, label: "aaaa"
      name = "aaaa"
      res  = auth_json_get area_name_exist_path, name: name, station_id: station.id, id: area.id
      expect(res[:status]).to eq(0)
      
    end
    it "create check and exist" do 
      station = create :station 
      area = create :area, station: station, label: "aaaa"
      name = "aaaa"
      res  = auth_json_get area_name_exist_path, name: name, station_id: station.id
      expect(res[:status]).to eq(1)
      
    end
    it "update check and exist" do 
      station = create :station 
      area = create :area, station: station, label: "aaaa"
      name = "aaaa"
      id = 34534534
      res  = auth_json_get area_name_exist_path, name: name, station_id: station.id, id: id
      expect(res[:status]).to eq(1)
      
    end
 
  end
  context "update area" do 
    it "success" do
      
      commission = create :commission 
      points = [{lantitude:13.10,longitude: 45.31},{lantitude: 34.2,longitude: 23.3}]
      label = "aa"
      code = "cc" 
      latitude = 12.4
      longitude = 23.5667
      distance = 345
      mian = 67.23
      points2 = create_list :point, 5
      station = create :station 
      area = create :area, station:station, points: points2, label: "abc", commission: commission,code: code
      res = auth_json_put update_area_path(area), label:label, points: points, station_id: station.id, commission_id: commission.id, latitude: latitude, longitude: longitude, distance: distance, mian: mian
      expect(res[:label]).to eq(label)
      expect(res[:points].size).to eq(2)
      expect(res[:code]).to eq(code)
      expect(res[:mian]).to eq(mian.to_s)
      expect(res[:distance]).to eq(distance)
      expect(res[:latitude]).to eq(latitude.to_s)
      expect(res[:longitude]).to eq(longitude.to_s)
    end
  end
  context "delete area" do 
    it "success" do
      
      points2 = create_list :point, 5
      station = create :station 
      area = create :area, station:station, points: points2, label: "abc"
      res = auth_data_delete update_area_path(area), id: area.id 
      expect(Point.all.size).to eq(0)
    end
  end

  context "get commission" do 
    it "success" do
      point1 = create :point, lantitude: 40.0536, longitude: 116.297
      point2 = create :point, lantitude: 40.0497, longitude: 116.298 
      point3 = create :point, lantitude: 40.0464, longitude: 116.303 
      point4 = create :point, lantitude: 40.0475, longitude: 116.311 
      point5 = create :point, lantitude: 40.0511, longitude: 116.311 
      point6 = create :point, lantitude: 40.0547, longitude: 116.308 
      point7 = create :point, lantitude: 40.055, longitude: 116.307 

      points = [point1,point2,point3,point4,point5,point6,point7]

      test_point = Hash.new 
      test_point[:lantitude] = 40.0521
      test_point[:longitude] = 116.305
 
      points2 = create_list :point, 5
      station = create :station, description: "aa" 
      commission = create :commission, price: 1
      area = create :area, station:station, points: points, label: "abc", commission: commission
      res = auth_json_get areas_commission_path, station_name: "aa", lantitude: test_point[:lantitude], longitude: test_point[:longitude] 
      expect(res[:message]).to eq(I18n.t("area.commission_success"))
      expect(res[:status]).to eq(0)
      expect(res[:price]).to eq(1.0)


    end
    it "address not in area" do 
      point1 = create :point, lantitude: 40.0536, longitude: 116.297
      point2 = create :point, lantitude: 40.0497, longitude: 116.298 
      point3 = create :point, lantitude: 40.0464, longitude: 116.303 
      point4 = create :point, lantitude: 40.0475, longitude: 116.311 
      point5 = create :point, lantitude: 40.0511, longitude: 116.311 
      point6 = create :point, lantitude: 40.0547, longitude: 116.308 
      point7 = create :point, lantitude: 40.055, longitude: 116.307 

      points = [point1,point2,point3,point4,point5,point6,point7]

      test_point3 = Hash.new 
      test_point3[:lantitude] = 40.046897
      test_point3[:longitude] = 116.299642


      points2 = create_list :point, 5
      station = create :station, description: "aa" 
      commission = create :commission, price: 1
      area = create :area, station:station, points: points, label: "abc", commission: commission

      res = auth_json_get areas_commission_path, station_name: "aa", lantitude: test_point3[:lantitude], longitude: test_point3[:longitude] 
      expect(res[:message]).to eq(I18n.t("area.address_not_in_station"))
      expect(res[:status]).to eq(3)
      expect(res[:price]).to eq(-1)

    end
    it "address not in area" do 
      point1 = create :point, lantitude: 40.0536, longitude: 116.297
      point2 = create :point, lantitude: 40.0497, longitude: 116.298 
      point3 = create :point, lantitude: 40.0464, longitude: 116.303 
      point4 = create :point, lantitude: 40.0475, longitude: 116.311 
      point5 = create :point, lantitude: 40.0511, longitude: 116.311 
      point6 = create :point, lantitude: 40.0547, longitude: 116.308 
      point7 = create :point, lantitude: 40.055, longitude: 116.307 

      points = [point1,point2,point3,point4,point5,point6,point7]

      test_point3 = Hash.new 
      test_point3[:lantitude] = 40.046897
      test_point3[:longitude] = 116.299642


      points2 = create_list :point, 5
      station = create :station, description: "aa" 
      commission = create :commission, price: 1

      res = auth_json_get areas_commission_path, station_name: "aa", lantitude: test_point3[:lantitude], longitude: test_point3[:longitude] 
      expect(res[:message]).to eq(I18n.t("area.not_exist"))
      expect(res[:status]).to eq(2)
      expect(res[:price]).to eq(-1)

    end


    it "station not exist" do
      test_point3 = Hash.new 
      test_point3[:lantitude] = 40.046897
      test_point3[:longitude] = 116.299642

      points2 = create_list :point, 5
      station = create :station, description: "aa" 
      commission = create :commission, price: 1
      area = create :area, station:station, label: "abc", commission: commission
      res = auth_json_get areas_commission_path, station_name: "bb", lantitude: test_point3[:lantitude], longitude: test_point3[:longitude] 
      expect(res[:status]).to eq(1)
      expect(res[:message]).to eq(I18n.t("area.station_not_exist"))
      expect(res[:price]).to eq(-1)
    end
 
  end

  context "test commission api" do 

    it "perform" do
       # Spreadsheet.client_encoding = 'UTF-8'
       #province_file = "#{G2.config.root_dir}/lib/assets/p.xls"
       #province_book = Spreadsheet.open province_file
       #province_sheet = province_book.worksheet 0
   
      #province_sheet.each_with_index do |row,index |
      #  if index >= 1
      #     description = row[1].strip
      #     lng = row[2]
      #     lat = row[3]
      #     startTime = Time.now
           
          # url = "http://localhost:9000/v1/areas/commission.json?station_name=#{description}&lantitude=#{lat}&longitude=#{lng}"
           # url = "http://api.cityhub.me/v1/areas/commission.json?station_name=#{description}&lantitude=#{lat}&longitude=#{lng}"
           # url = "https://api-commission.wuliusys.com/v1/areas/commission.json?station_name=#{description}&lantitude=#{lat}&longitude=#{lng}"
           #File.open("/Users/liuhaibao/local.txt", "a+") do | f | 
           #   f.puts url
           #end
         

          #  response = RestClient.get 'http://api.cityhub.me/v1/areas/commission.json', {:params => {:station_name => description, :lantitude => lat, :longitude=> lng}}
       #    endTime = Time.now
 
          #  puts "#{response} : #{endTime - startTime} " 

        #end
      # end

    end
  end    


end
