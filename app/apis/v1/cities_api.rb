class V1::CitiesApi < Grape::API

  helpers do
    def logger
       V1::AreasApi.logger
    end
  end

  before do 
    key_authenticate!
  end 
  params do 
    optional :signature, type:String
    requires :api_key, type: String
  end
  
  namespace :cities do
    params do 
      requires :id, type: String
    end
    get ":id/districts" do 
      districts = City.find(params[:id]).districts
      present districts, with: DistrictEntity

    end

    desc "获取市下站点", {
      entity: StationEntity
    }
    params do
      requires :id, type: Integer
    end
    get ":id/stations" do
      stations = Station.where(stationable_id:params[:id],stationable_type:"City")
      present stations, with: StationEntity
    end


  end
end
