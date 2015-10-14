require 'spec_helper'

describe AccessHelper do 

  context "auth" do 
    it "sign test" do 
      api_secret = "adfasdfasd"
      params = {station:"c",a:"b",api_key:"cc"}
      signature = sign_params(params, api_secret)

      binding.pry

      
    end
  end
end
