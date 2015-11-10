class V1::StationsApi < Grape::API
  namespace :stations do

    desc "获取city 下 station", {
      entity: StationEntity
    }
    params do 
      requires :city_id, type: Integer
      requires :api_key, type: String
    end
    get "city" do
      key_authenticate!
      stations = City.find(params[:city_id]).stations
      present stations, with: StationEntity
    end

    desc "获取city 下没有画好的 station", {
      entity: StationEntity
    }
    params do 
      requires :city_id, type: Integer
      requires :api_key, type: String
    end
 
    get "nopoints" do
      key_authenticate!
      stations = Station.where(stationable_id:params[:city_id],stationable_type:"City").includes(:points).where(points:{pointable_id:nil})
      present stations, with: StationEntity
    end
    
    desc "获取station", {
      entity: StationEntity
    }
    params do 
      requires :id, type: String
      requires :api_key, type: String
    end
 
    get ":id" do
      key_authenticate!
      station = Station.find(params[:id])
      present station, with: StationEntity
    end
    
    desc "创建station ", {
      entity: StationEntity
    } 
    params do 
      requires :api_key, type: String
      optional :description, type:String 
      requires :stationable_id, type:String 
      requires :stationable_type, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
 
    end
    post do 
      key_authenticate!
      station = Station.create description: params[:description], lantitude: params[:lantitude], longitude: params[:longitude], address: params[:address], stationable_id: params[:stationable_id], stationable_type: params[:stationable_type] 
      points = params[:points]
      points.each do  |point|
        station.points.create lantitude: point.lantitude, longitude: point.longitude
      end 
      present station, with: StationEntity
      
    end
    desc "更新station ", {
      entity: StationEntity
    } 
    params do 
      requires :api_key, type: String
      requires :id, type: Integer
      optional :description, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    put ":id" do 
      key_authenticate!
      station = Station.find(params[:id])
      station_params = Hash.new
      station_params[:description] = params[:description] if params[:description]
      station_params[:lantitude] = params[:lantitude] if params[:lantitude]
      station_params[:longitude] = params[:longitude] if params[:longitude]
      station_params[:address] = params[:address] if params[:address]

      station.update! station_params

      points = params[:points]

      unless points.nil?
        ps = []
        points.each do  |point|
          p = Point.create lantitude: point.lantitude, longitude: point.longitude 
          ps << p
        end 
        station.points = ps
        station.save!
      end

      present station, with: StationEntity
      
    end

    desc "同步station ", {
      entity: StationEntity
    } 
    params do 
      requires :id, type: Integer
      optional :description, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post ":id/sync" do 
      station = Station.where(id:params[:id]).first_or_create
      station_params = Hash.new
      station_params[:description] = params[:description] if params[:description]
      station_params[:lantitude] = params[:lantitude] if params[:lantitude]
      station_params[:longitude] = params[:longitude] if params[:longitude]
      station_params[:address] = params[:address] if params[:address]

      station.update! station_params

      points = params[:points]

      unless points.nil?
        ps = []
        points.each do  |point|
          p = Point.create lantitude: point.lantitude, longitude: point.longitude 
          ps << p
        end 
        station.points = ps
        station.save!
      end

      present station, with: StationEntity
      
    end
    
    desc "获取站点下区域", {
      entity: AreaEntity
    }
    params do 
      requires :api_key, type: String
 
      requires :id, type: Integer 
    end
 
    get ":id/areas" do
      key_authenticate!
      areas = Station.find(params[:id]).areas
      present areas, with: AreaEntity
    end


    desc "删除站点", {
      entity: StationEntity
    }
    params do 
      requires :api_key, type: String
 
      requires :id, type: Integer 
    end
    delete ":id" do 
      key_authenticate!
      station = Station.destroy(params[:id])
      present station, with: StationEntity
    end


  end
end
