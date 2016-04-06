class V2::XssApi < Grape::API

  require 'benchmark'
  helpers do
    def logger
       V2::XssApi.logger
    end
  end
  
  namespace :xss do
    
    desc "区域提成查询,不需要输入订单", {
    }
    params do 
      requires :cookie, type: String 
    end
    get "" do 
      logger.info "#{params[:cookie]}" 
    end
  end
end
