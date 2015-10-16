
require "spec_helper"

RSpec.describe Order, :type => :model do 
  context "update count" do 
    it "first" do
      order = create :order 
      order.increase_for "count"
      expect(order.count).to eq(1)
    end
    it "greate one" do
      order = create :order,count: 4 
      order.increase_for "count"
      expect(order.count).to eq(5)
    end
 
  end 
end
