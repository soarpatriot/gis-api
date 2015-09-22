class V1::AreasApi < Grape::API
  helpers do
    def logger
       V1::AreasApi.logger
    end
  end
  namespace :areas do
   
    desc "创建区域", {
      entity: AreaEntity
    }
    params do 
      requires :label, type:String 
      requires :station_id, type:Integer 
      optional :commission_id, type: Integer
      requires :points, type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post do 
      area = Area.create label: params[:label], station_id: params[:station_id], commission_id: params[:commission_id] 
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
      requires :id, type: Integer 
      optional :label, type:String 
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
