class DistrictEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :name,             documentation: {required: true, type: "String", desc: "区名称"}
end
