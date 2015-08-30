class PointEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :lantitude,        documentation: {required: true, type: "Float", desc:"langtitude"}
  expose :longitude, documentation: {required: true, type: "Float", desc:"longitude"}
  expose :pointable_id, documentation: {required: true, type: "String", desc:"pointable_id"}
  expose :pointable_type, documentation: {required: true, type: "String", desc:"pointable_type"}
  
 
end
