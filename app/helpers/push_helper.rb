module PushHelper
  
  def push_to_ios device_token, alert=nil, data={}
    Rpush::Apns::Notification.new(device_token: device_token, alert: alert, data: data, app: $ios_app).save!
  end

  def push_to_android device_token, data={}
    # Rpush::Apns::Notification.new(device_token: device_token, data: data, app: $ios_app).save!
  end

end
