require "point_entity"
class AreaEntity < Grape::Entity

  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :label,             documentation: {required: true, type: "String", desc: "区域名称"}
  expose :points, using: PointEntity 
  # expose :points, using: PointEntity
end
