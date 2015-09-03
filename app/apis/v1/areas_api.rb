class V1::AreasApi < Grape::API

  namespace :areas do
   
    desc "创建区域", {
      entity: AreaEntity
    }
    params do 
      requires :label, type:String 
      requires :station_id, type:Integer 
      requires :points, type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post do 
      area = Area.create label: params[:label], station_id: params[:station_id] 
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
      optional :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    put ":id" do 
      area = Area.find(params[:id])
      area_params = Hash.new
      area_params[:label] = params[:label] if params[:label]

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


  end
end
