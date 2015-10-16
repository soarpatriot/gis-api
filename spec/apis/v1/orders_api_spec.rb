require "spec_helper"

describe V1::OrdersApi do

  let(:orders_path) { "/v1/orders" }
  
  def search_path code 
    "v1/orders/#{code}"
  end 
 
  context "all orders" do 
    it "get one" do
      code = 3
      res = json_get search_path code 
      expect(res.size).to eq(3)
    end
  end

end
