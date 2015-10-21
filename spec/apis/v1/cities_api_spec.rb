require "spec_helper"

describe V1::CitiesApi do

  let(:cities_path) { "/v1/citiess" }
 
  def city_districts_path city 
    "v1/cities/#{city.id}/districts"
  end 
 
  context "get districts area" do
    it "one" do 
      districts = create_list :district, 10
      city = create :city, districts: districts 
      res = auth_json_get city_districts_path(city)
      expect(res.size).to eq(10)
    end
  end 
end
