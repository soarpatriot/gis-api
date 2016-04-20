class V1::AreasApi < Grape::API
  helpers do
    def user_info cookie_value
      unless cookie_value.nil?
        price_url = Settings.price_url
        user = RestClient.get "#{price_url}/users/cookie?cookie_value=#{cookie_value}"
        user_info = JSON.parse user 
        user_info
        
      end
    end
    def notify user, pre_content, post_content 
      unless user.nil?
        price_url = Settings.price_url
        begin 
          Thread.new do 
            result = RestClient.post "#{price_url}/emails/area", user_id: user[:id], user_name: user[:name], pre_content: pre_content, post_content:post_content  
          end
        rescue
          logger.info "notify user error"
        end
      end 
    end
    def log_create_info cookie_value, params 
      user = user_info cookie_value
      message =  "create new area by: #{user},  commission: #{params[:commission_id]}"
      logger.info message
      notify user, "创建新区域", message 
    end

    def log_change_area cookie_value, params, area 
      user = user_info cookie_value
      pre_content =  "update area by: #{user}, old value: area_id: #{area.to_json}, price: #{area.commission.try(:to_json)}, " 
      post_content = "  commission  params: #{params[:commission_id]}"

      logger.info pre_content + post_content
      notify user, pre_content, post_content
    end
  end

  before do 
    key_authenticate!
  end 
  params do 
    optional :signature, type:String
    requires :api_key, type: String
  end
  
  namespace :areas do
    desc "验证区域编号",{
        entity: AreaEntity
    }
    params do
      requires :code,type:String
      requires :station_id,type:Integer
      optional :area_id,type:Integer
    end
    get "exists" do
      areas = Area.where(station_id: params[:station_id],code: params[:code])
      if params[:area_id]
        areas = areas.where.not(id: params[:area_id])
        #binding.pry
      end
      !areas.exists?
    end
    desc "验证区域名称",{
        entity: AreaEntity
    }
    params do
      requires :name,type:String
      requires :station_id,type:Integer
      optional :id,type:Integer
    end
    get "name-exist" do
      area = Area.where(station_id: params[:station_id], label: params[:name]).first
      if area.nil?
        return  {status:0}
      end

      if area.id == params[:id]
        return  {status:0}
      end 
      
      return  {status:1}
    end


    desc "创建区域", {
      entity: AreaEntity
    }
    params do 
      requires :label, type:String 
      optional :code, type:String 
      optional :latitude, type:Float 
      optional :longitude, type:Float 
      optional :mian, type:String 
      optional :distance, type:Integer 
      requires :station_id, type:Integer 
      optional :commission_id, type: Integer
      optional :user_info,type:String
      requires :points, type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post do 
      area = Area.create(
        label: params[:label], 
        station_id: params[:station_id], 
        commission_id: params[:commission_id],
        code: params[:code],
        mian: params[:mian],
        latitude: params[:latitude],
        longitude: params[:longitude], 
        distance: params[:distance]
      )
      points = params[:points]
      points.each do  |point|
        area.points.create lantitude: point.lantitude, longitude: point.longitude
      end 
      cookie_value = cookies[:LoginUserInfo] 

      log_create_info cookie_value, params

      present area, with: AreaEntity
    end

    desc "更新区域", {
      entity: AreaEntity
    }
    params do 
      requires :id, type: Integer 
      optional :label, type:String 
      optional :code, type:String 
      optional :mian, type:String 
      optional :latitude, type:Float 
      optional :longitude, type:Float 
      optional :distance, type:Integer 
 
      requires :station_id, type:Integer 
      optional :commission_id, type: Integer
      optional :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    put ":id" do 
      area = Area.find(params[:id])
      area_params = Hash.new
      area_params[:label] = params[:label] if params[:label]
      area_params[:code] = params[:code] if params[:code]
      area_params[:latitude] = params[:latitude] if params[:latitude]
      area_params[:longitude] = params[:longitude] if params[:longitude]
      area_params[:distance] = params[:distance] if params[:distance]
      area_params[:mian] = params[:mian] if params[:mian]
      area_params[:commission_id] = params[:commission_id] if params[:commission_id]
      
      cookie_value = cookies[:LoginUserInfo] 
      log_change_area cookie_value, params, area

      area.update! area_params

      points = params[:points]

      unless points.nil?
        ps = []
        points.each do  |point|
          p = Point.create lantitude: point.lantitude, longitude: point.longitude 
          ps << p
        end 
        area.points = ps
        area.save!
      end

      present area, with: AreaEntity

    end

    desc "删除区域", {
      entity: AreaEntity
    }
    params do 
      requires :id, type: Integer 
    end
    delete ":id" do 
      area = Area.destroy(params[:id])
      present area, with: AreaEntity
    end
     
    desc "区域提成查询", {
    }
    params do 
      requires :station_name, type: String 
      requires :lantitude, type: Float
      requires :longitude, type: Float
    end
    get "commission" do 
      price = -1
      point = Hash.new 
      point[:lantitude] = params[:lantitude]
      point[:longitude] = params[:longitude]
      station = Station.where(description: params[:station_name]).try(:first) 
      
      flag = false

      if station.nil? 
        return  {status:1, message: I18n.t("area.station_not_exist"),price: -1}
      end  
      
      areas = station.areas 
      if areas.size == 0
        return  {status:2, message: I18n.t("area.not_exist"),price: -1}
      end 

      # startTime = Time.now      
      areas.each do |area| 
        if area.include_point? point
          price =  area.commission.price
          flag = true
          break
        end 
      end 

    #  i = 0
    #  while i <= areas.size 
    #    if areas[i].include_point? point
    #      price =  areas[i].commission.price
    #      flag = true
    #      break
    #    end 
    #    i += 1
    #  end
      # endTime = Time.now
      # logger.info "point in area cost #{endTime-startTime}"

      if flag 
        return  {status:0, message: I18n.t("area.commission_success"),price: price}
      else
        return  {status:3, message: I18n.t("area.address_not_in_station"),price: -1}
      end
    end
  end
end
