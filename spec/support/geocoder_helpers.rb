module GeocoderHelpers
  
  def map_api_result
    <<-RESULT
      {
        "status": 0,
        "result": {
          "location": {
            "lng": 123.123,
            "lat": 39.400
          },
          "formatted_address": "辽宁省大连市长海县",
          "business": "",
          "addressComponent": {
            "city": "大连市",
            "district": "长海县",
            "province": "辽宁省",
            "street": "",
            "street_number": ""
          },
          "cityCode": 167
        }
      }
    RESULT
  end

  def map_api_url lat, lon

    "http://api.map.baidu.com/geocoder/v2/?ak=4abeaefcc6f753454346f612d8636ba8&location=#{lat},#{lon}&output=json"
  end

end

RSpec.configure do |config|
  config.include GeocoderHelpers
end
