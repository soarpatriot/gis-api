module NotifyHelper
    def notify_area user, pre_content, post_content 
      unless user.nil?
        price_url = Settings.price_url
        RestClient.post "#{price_url}/emails/area", user_id: user[:id], user_name: user[:name], pre_content: pre_content, post_content:post_content  
      end 
    end
 
end
