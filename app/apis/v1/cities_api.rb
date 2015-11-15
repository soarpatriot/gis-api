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
    requires :signature, type:String
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
  end
end
