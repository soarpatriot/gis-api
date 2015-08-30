require 'rest-client'

module SmsHelper

  def send_captcha code, mobile
    content = I18n.t :code_message, code: code
    content = content.force_encoding("gbk")
    content.encode! 'gbk', 'utf-8'
    post_data = {
      username: "soundink",
      password: "soundink123",
      apikey: "e3eb217cbf98b328f3b4c2cdd53e813a",
      mobile: mobile,
      content: content
    }
    res = RestClient.post "http://115.28.23.78/api/send/?", post_data
    if res.match(/^success/)
      true
    else
      nil
    end
  end

end
