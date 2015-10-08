module AccessHelper

  def token_authenticate!
    error!("4010", 401) if params[:auth_token].nil?
    error!('4014', 401) unless current_user
  end
  
  def key_authenticate!
    origin = env["HTTP_ORIGIN"]
    error!("4011", 401) if params[:app_key].nil?
    #origin = env["HTTP_ORIGIN"]
    error!("4012", 401) if Key.where(origin: origin,app_key: params[:app_key]).first.nil?
  end

  def current_user
    @current_user ||= AuthToken.where(value: params[:auth_token]).first.try(:user)
  end

end
