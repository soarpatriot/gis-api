require 'spec_helper'

include NotifyHelper
describe NotifyHelper, type: :helper do 
 context "sending email" do 
    it "send" do 
      user = Hash.new
      params = Hash.new
      user[:id] = 1212
      user[:name] = "sdfas"
      user[:code] = "sdfasdf"
      commission = create :commission, price: 2.1
      params[:commission_id] = commission.id
      station = create :station, description:"aa"
      area = create :area, station: station, commission: commission       

      notify_area user,  params,area, 1
 
    end
  end
end
