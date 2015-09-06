class CityEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :description,             documentation: {required: true, type: "String", desc: "城市名称"}
end
