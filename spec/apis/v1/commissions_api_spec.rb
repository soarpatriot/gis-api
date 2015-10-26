require "spec_helper"

describe V1::CommissionsApi do

  let(:commissions_path) { "/v1/commissions" }
  
 
  context "all commissions" do 
    it "get all" do

      create_list :commission, 5
      res = auth_json_get commissions_path 
      expect(res.size).to eq(5)
    end
    it "order by price asc" do

      create :commission, price: 0.8
      create :commission, price: 0.3
      create :commission, price: 0.5
      res = auth_json_get commissions_path 
      expect(res[0][:price]).to eq(0.3)
    end

  end

end
