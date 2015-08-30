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

  end
end
