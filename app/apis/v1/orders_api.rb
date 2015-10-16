class V1::OrdersApi < Grape::API
 
  namespace :orders do
    
    desc "区域提成查询", {
    }
    params do 
      requires :code, type: String 
    end
    get ":code" do 
      return  {order_number:"a12344", delivery:"xiao",price: 1.03}
    end
  end
end
