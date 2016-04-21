require 'spec_helper'

include NotifyHelper
describe NotifyHelper, type: :helper do 
  context "auth" do 
    it "sort_params test" do 
      user = Hash.new
      user[:id] = 1212
      user[:name] = "sdfas"
      user[:code] = "sdfasdf"
      notify_area user, "ss", "sss" 
       
      
    end
  end
end
