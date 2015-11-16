class V1::ProvincesApi < Grape::API

  before do 
    key_authenticate!
  end 
  params do 
    optional :signature, type:String
    requires :api_key, type: String
  end
  namespace :provinces do
    
    desc "获取省下市", {
      entity: CityEntity
    }
    params do
      requires :id, type: Integer
    end
    get ":id/cities" do
      cities = Province.find(params[:id]).cities
      present cities, with: CityEntity
    end

  end
end
