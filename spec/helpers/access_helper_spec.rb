require 'spec_helper'

include AccessHelper
describe AccessHelper, type: :helper do 
  context "auth" do 
    it "sort_params test" do 
      params = {station:"c", a:"b", api_key:"cc",signature:"abcsd"}
      expect_str = "a=b&api_key=cc&station=c"
      sorted_str = sort_params(params)
      
      expect(sorted_str).to eq(expect_str)

      
    end
  end
end
