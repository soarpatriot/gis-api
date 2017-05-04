module NotifyHelper
    def logger
      Logger.new('log/logfile.log')
    end
 
    def user_info cookie_value
      unless cookie_value.nil?
        price_url = Settings.price_url
        begin 
          url = "#{price_url}/v2/employees/token?token=#{cookie_value}"
          user = RestClient::Request.execute(method: :get, url: url,
                   timeout: 3, open_timeout: 2)
          #user = RestClient.get "#{price_url}/users/cookie?cookie_value=#{cookie_value}"
          user_hash = JSON.parse user, symbolize_names: true 
        rescue  Exception => e
          logger.info  "exception e:  #{e}"
        end
  
        user_hash
        
      end
    end
 
    def notify_area user, params, area, opt_type 
      unless user.nil?
        price_url = Settings.price_url
        after_price = Commission.find(params[:commission_id]).try(:price)
        station_name = area.try(:station).try(:description)
        logger.info "area: #{area}"
        begin 
          result = RestClient::Request.execute method: :post, 
              url:  "#{price_url}/emails/area/note", 
              timeout: 3,
              open_timeout: 2,
              payload: {opt_type: opt_type,
              user_id: user[:employeeid],
              user_name: user[:employeename],
              user_code: user[:employeecode],
              station_name: station_name,
              area_name_before: area.label, 
              area_name_after: params[:label], 
              area_code_before: area.code, 
              area_code_after: params[:code], 
              area_mian_before: area.mian, 
              area_mian_after: params[:mian], 
              price_before: area.try(:commission).try(:price), 
              price_after: after_price,
              update_at_before: area.updated_at.strftime('%Y-%m-%d %H:%M:%S'),
              update_at_after: Time.now.strftime('%Y-%m-%d %H:%M:%S')}.to_json,
              headers: {
                content_type: :json,
                accept: :json
              }
            logger.info result.force_encoding('utf-8').encode
        rescue  Exception => e
          logger.info  "exception e:  #{e}"
        end
      end 
    end
    def log_create_info cookie_value, params, area
      user = user_info cookie_value
      commission = Commission.find(params[:commission_id]) unless params[:commission_id].nil?
      message =  "create new area by: #{user},  params: #{params},area: #{area.to_json}, price: #{commission.try(:to_json)}"
      logger.info message
      notify_area user, params, area, 1
    end

    def log_change_area cookie_value, params, area 
      user = user_info cookie_value
      commission = Commission.find(params[:commission_id]) unless params[:commission_id].nil?
      pre_content =  "update area by: #{user}, old value: area_id: #{area.to_json}, price: #{area.commission.try(:to_json)}, " 
      post_content = "  params: #{params}, price: #{commission.try(:to_json)}  "

      logger.info pre_content + post_content
      notify_area user, params, area, 2
    end
 
end
