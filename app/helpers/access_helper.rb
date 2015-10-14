module AccessHelper

  def token_authenticate!
    error!("4010", 401) if params[:auth_token].nil?
    error!('4014', 401) unless current_user
  end
  
  def key_authenticate!
    origin = env["HTTP_ORIGIN"]
    error!("4011", 401) if params[:api_key].nil?
    #origin = env["HTTP_ORIGIN"]
    key = Key.where(api_key: params[:api_key]).first
    error!("4012", 401) if key.js? && key.origin != origin  

    signature = params[:signature]

    if key.server?
      error!("4013", 401) unless sign(params, key.api_secret) == signature
    end
   
  end

  def current_user
    @current_user ||= AuthToken.where(value: params[:auth_token]).first.try(:user)
  end

  def sign_params params,api_secret
    sign_str = params.keys.sort.map{ |k,v| "#{k}=#{v}" if k != "signature" }.join("&") + api_secret
    binding.pry
    Digest::SHA1.hexdigest(sign_str)
  end


end
