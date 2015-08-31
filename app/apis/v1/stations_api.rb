class V1::StationsApi < Grape::API

  namespace :stations do

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
      requires :description, type:String 
      requires :lantitude, type:Float 
      requires :longitude, type:Float
      requires :address, type:String 
      requires :points,type:Array do 
        requires :lantitude
        requires :longitude
      end
    end
    post do 
      station = Station.create description: params[:description], lantitude: params[:lantitude], longitude: params[:longitude], address: params[:address] 
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
    
    
  end
end
