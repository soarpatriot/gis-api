require "point_entity"
class StationEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :description,             documentation: {required: true, type: "String", desc: "站点名称"}
  expose :address,             documentation: {required: true, type: "String", desc: "站点地址"}
  expose :lantitude,             documentation: {required: true, type: "String", desc: "站点经度"}
  expose :longitude,             documentation: {required: true, type: "String", desc: "站点纬度"}
  expose :status,             documentation: {required: true, type: "String", desc: "站点状态"}
  
  expose :points, using: PointEntity 
end
