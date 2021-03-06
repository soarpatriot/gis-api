require "grape-swagger"
class ApiV2 < Grape::API

  use Rack::Cors do
    allow do
      origins '*'
      resource '*', headers: :any, methods: [:get, :put, :post, :options, :delete]
    end
  end

  include Grape::Kaminari
  version :v2
  format :json
  paginate per_page: 15

  before do
    I18n.locale = "zh-CN"
  end

  get do
    {
        name: "v2"
    }
  end

  helpers AccessHelper
  helpers ApplicationHelper

  mount V2::AreasApi
  mount V2::XssApi

  add_swagger_documentation  api_version:"v2", base_path: Settings.host
  # http://api.dreamreality.cn/v1/swagger_doc.json   
  #add_swagger_documentation
  # add_swagger_documentation api_version: "v1", markdown: true
  # add_swagger_documentation api_version: "v2", markdown: true
end
