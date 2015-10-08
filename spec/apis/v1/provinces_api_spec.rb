require "spec_helper"

describe V1::ProvincesApi do

  def province_cities_path province 
    "v1/provinces/#{province.id}/cities"
  end 
 
  context "provice cities" do 
    it "get one province cities" do

      cities = create_list :city, 2
      cities1 = create_list :city, 3

      province = create :province, cities: cities
      province1 = create :province, cities: cities1
      res = auth_json_get province_cities_path(province), id: province.id 
      expect(res.size).to eq(2)
    end
  end

end
