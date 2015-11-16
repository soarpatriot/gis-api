require "rack/test"

module RackTestHelpers
  def app
    ServiceApplication
  end

  def current_user
    @user ||= create :user
  end

  def current_token
    @token ||= AuthToken.create user: current_user
  end
  
  def current_key
    @key ||= Key.create  api_key: "123", ktype: Key.ktypes[:js], api_secret: "678"
  end

  def json_post url, data={}
    post url, data
    JSON.parse last_response.body, symbolize_names: true
  end
  def json_put url, data={}
    put url, data
    JSON.parse last_response.body, symbolize_names: true
  end


  def json_get url, data={}
    get url, data
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_get url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_secret 
    get url, data.merge(api_key: current_key.api_key,signature: signature)
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_post url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_secret 
    post url, data.merge(api_key: current_key.api_key,signature: signature).to_json, {"CONTENT_TYPE"=> 'application/json'}
 
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_data_post url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_key 
    post url, data.merge(api_key:current_key.api_key,signature: signature).to_json, {"CONTENT_TYPE"=> 'application/json'}
 
    p last_response.body
    p last_response.headers
    JSON.parse last_response.body, symbolize_names: true
  end

  def data_post url, data={}
    post url, data.merge(auth_token: current_token.value)
    last_response
  end

  def data_delete url, data={}
    delete url, data 
    last_response
  end
  
  def auth_data_delete url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_secret 
    delete url, data.merge(api_key:current_key.api_key,signature: signature).to_json, {"CONTENT_TYPE"=> 'application/json'}
 
    last_response
  end



  def auth_json_put url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_key 
    put url, data.merge(api_key:current_key.api_key,signature: signature).to_json, {"CONTENT_TYPE"=> 'application/json'}
 
    JSON.parse last_response.body, symbolize_names: true
  end

  def auth_json_delete url, data={}
    temp_data = data.merge(api_key: current_key.api_key)
    signature  = sign_params temp_data,current_key.api_key 
    delete url, data.merge(api_key:current_key.api_key,signature: signature).to_json, {"CONTENT_TYPE"=> 'application/json'}
 
    JSON.parse last_response.body, symbolize_names: true
  end

  private 
    def sign_params params,api_secret
      Digest::SHA1.hexdigest(sort_params(params) + api_secret)
    end

    def sort_params params
      sorted_arr = []
      params.keys.sort.map  do | k |
        sorted_arr << "#{k}=#{params[k]}" if k != :signature && k != 'signature'  
      end 
        
      sorted_arr.join("&")
    end


end

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RackTestHelpers
end
