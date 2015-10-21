class V2::AreasApi < Grape::API
  helpers do
    def logger
       V2::AreasApi.logger
    end
  end
  
  namespace :areas do
    
    desc "创建区域", {
      entity: AreaEntity
    }
    params do 
      requires :api_key, type: String
      requires :label, type:String 
      optional :code, type:String 
      optional :latitude, type:Float 
      optional :longitude, type:Float 
      optional :mian, type:String 
      optional :distance, type:Integer 
      requires :station_id, type:Integer 
      optional :commission_id, type: Integer
      requires :points, type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post do 
      key_authenticate!
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
      present area, with: AreaEntity
    end

    desc "更新区域", {
      entity: AreaEntity
    }
    params do 
      requires :api_key, type: String
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
      key_authenticate!
      area = Area.find(params[:id])
      area_params = Hash.new
      area_params[:label] = params[:label] if params[:label]
      area_params[:code] = params[:code] if params[:code]
      area_params[:latitude] = params[:latitude] if params[:latitude]
      area_params[:longitude] = params[:longitude] if params[:longitude]
      area_params[:distance] = params[:distance] if params[:distance]
      area_params[:mian] = params[:mian] if params[:mian]
      area_params[:commission_id] = params[:commission_id] if params[:commission_id]

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
      requires :api_key, type: String
      requires :id, type: Integer 
    end
    delete ":id" do 
      key_authenticate!
      area = Area.destroy(params[:id])
      present area, with: AreaEntity
    end
     
    desc "区域提成查询", {
    }
    params do 
      requires :station_id, type: Integer 
      requires :order_code, type: String
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
      order = Order.first_or_create(station_id: params[:station_id],code: params[:order_code])
      order.update latitude: params[:lantitude], longitude: params[:longitude], station_name: params[:station_name]
      order.increase_for "count"
     
      if station.nil? 
        order.no_station!
        return  {status:1, message: I18n.t("area.station_not_exist"),price: -1}
      end  
      
      areas = station.areas 
      if areas.size == 0
        order.no_areas!
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

      if flag 
        order.success!
        return  {status:0, message: I18n.t("area.commission_success"),price: price}
      else
        order.not_in_areas!
        return  {status:3, message: I18n.t("area.address_not_in_station"),price: -1}
      end
    end
  end
end