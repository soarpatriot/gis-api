class StationEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
 
end
