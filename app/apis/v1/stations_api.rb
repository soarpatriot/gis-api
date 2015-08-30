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
    
  end
end
