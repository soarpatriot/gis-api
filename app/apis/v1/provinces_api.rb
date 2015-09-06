class V1::ProvincesApi < Grape::API

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
