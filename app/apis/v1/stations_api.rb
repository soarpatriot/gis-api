class V1::StationsApi < Grape::API

  before do 
    key_authenticate!
  end 
  params do 
    optional :signature, type:String
    requires :api_key, type: String
  end
 
  namespace :stations do

    desc "获取city 下 station", {
      entity: StationEntity
    }
    params do 
      requires :city_id, type: Integer
    end
    get "city" do
      stations = City.find(params[:city_id]).stations
      present stations, with: StationEntity
    end

    desc "获取city 下没有画好的 station", {
      entity: StationEntity
    }
    params do 
      requires :city_id, type: Integer
    end
 
    get "nopoints" do
      stations = Station.where(stationable_id:params[:city_id],stationable_type:"City").includes(:points).where(points:{pointable_id:nil})
      present stations, with: StationEntity
    end
    
    desc "获取station", {
      entity: StationEntity
    }
    params do 
      requires :id, type: String
    end
 
    get ":id" do
      station = Station.find(params[:id])
      present station, with: StationEntity
    end
    
    desc "创建station ", {
      entity: StationEntity
    } 
    params do 
      optional :description, type:String 
      requires :stationable_id, type:String 
      requires :stationable_type, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points,type:String  
 
    end
    post do 
      station = Station.create description: params[:description], lantitude: params[:lantitude], longitude: params[:longitude], address: params[:address], stationable_id: params[:stationable_id], stationable_type: params[:stationable_type] 
      points = JSON.parse(params[:points], symbolize_names: true) if params[:points]
      points.each do  |point|
        station.points.create lantitude: point[:lantitude], longitude: point[:longitude]
      end 
      present station, with: StationEntity
      
    end
    desc "更新station ", {
      entity: StationEntity
    } 
    params do 
      requires :id, type: Integer
      optional :description, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points, type:String
    end
    put ":id" do 
      station = Station.find(params[:id])
      station_params = Hash.new
      station_params[:description] = params[:description] if params[:description]
      station_params[:lantitude] = params[:lantitude] if params[:lantitude]
      station_params[:longitude] = params[:longitude] if params[:longitude]
      station_params[:address] = params[:address] if params[:address]

      station.update! station_params

      points = JSON.parse(params[:points], symbolize_names: true) if params[:points]

      unless points.nil?
        ps = []
        points.each do  |point|
          p = Point.create lantitude: point[:lantitude], longitude: point[:longitude] 
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
      optional :city_id, type:Integer 
      optional :description, type:String 
      optional :lantitude, type:Float 
      optional :longitude, type:Float
      optional :address, type:String 
      optional :points,type:String  
    end
    post ":id/sync" do 
      station = Station.where(id:params[:id]).first_or_create
      city = City.where(id:params[:city_id]).first if params[:city_id]
      station_params = Hash.new
      station_params[:description] = params[:description] if params[:description]
      station_params[:lantitude] = params[:lantitude] if params[:lantitude]
      station_params[:longitude] = params[:longitude] if params[:longitude]
      station_params[:address] = params[:address] if params[:address]

      station.update! station_params

      points = JSON.parse(params[:points], symbolize_names: true) if params[:points]
      unless points.nil?
        ps = []
        points.each do  |point|
          p = Point.create lantitude: point[:lantitude], longitude: point[:longitude] 
          ps << p
        end 
        station.points = ps
        station.stationable = city unless city.nil?
        station.save!
      end

      present station, with: StationEntity
      
    end
    
    desc "获取站点下区域", {
      entity: AreaEntity
    }
    params do 
      requires :id, type: Integer 
    end
 
    get ":id/areas" do
      areas = Station.find(params[:id]).areas
      present areas, with: AreaEntity
    end


    desc "删除站点", {
      entity: StationEntity
    }
    params do 
      requires :id, type: Integer 
    end
    delete ":id" do 
      station = Station.destroy(params[:id])
      present station, with: StationEntity
    end


  end
end
