require "spec_helper"

describe V1::CommissionsApi do

  let(:commissions_path) { "/v1/commissions" }
  
 
  context "all commissions" do 
    it "get all" do

      create_list :commission, 5
      res = json_get commissions_path 
      expect(res.size).to eq(5)
    end
  end

end
