module AccessHelper

  def token_authenticate!
    error!("4010", 401) if params[:auth_token].nil?
    error!('4014', 401) unless current_user
  end
  
  def key_authenticate!
    logger.info "cookies:  #{cookies}"

    origin = env["HTTP_ORIGIN"]
    error!("4011", 401) if params[:api_key].nil?
    #origin = env["HTTP_ORIGIN"]
    key = Key.where(api_key: params[:api_key]).first

    if key.js?
      re_key = Key.where(origin: origin, api_key: params[:api_key]).first
      error!("4012",401) if re_key.nil? or re_key.origin != origin
    end
    
    if key.server?
      signature = params[:signature]
      error!("4013", 401) unless sign_params(params, key.api_secret) == signature
    end
   
  end

  def current_user
    @current_user ||= AuthToken.where(value: params[:auth_token]).first.try(:user)
  end

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

  def logger
    Grape::API.logger
  end
 
end
