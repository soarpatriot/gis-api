module NotifyHelper
    def logger
      Logger.new('log/logfile.log')
    end
 
    def user_info cookie_value
      unless cookie_value.nil?
        price_url = Settings.price_url
        user = RestClient.get "#{price_url}/users/cookie?cookie_value=#{cookie_value}"
        user_hash = JSON.parse user, symbolize_names: true 
        user_hash
        
      end
    end
 
    def notify_area user, params, area, opt_type 
      unless user.nil?
        price_url = Settings.price_url
        after_price = Commission.find(params[:commission_id]).try(:price)
        station_name = area.try(:station).try(:description)
        begin 
          Thread.new do
            result = RestClient.post "#{price_url}/emails/area/note", 
              {opt_type: opt_type,
              user_id: user[:id],
              user_name: user[:name], 
              user_code: user[:code], 
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
              content_type: :json,
              accept: :json
            logger.info result.force_encoding('utf-8').encode
          end
        rescue  Exception => e
          logger.info  "exception e:  #{e}"
        end
      end 
    end
    def log_create_info cookie_value, params, area
      user = user_info cookie_value
      commission = Commission.find(params[:commission_id]) unless params[:commission_id].nil?
      message =  "create new area by: #{user},  params: #{params[:commission_id]}, price: #{commission.try(:to_json)}"
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
