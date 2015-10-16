require "point_entity"
class AreaEntity < Grape::Entity

  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :label,             documentation: {required: true, type: "String", desc: "区域名称"}
  expose :code,             documentation: {required: true, type: "String", desc: "区域编码"}
  expose :latitude,             documentation: {required: true, type: "Float", desc: "中心点纬度"}
  expose :longitude,             documentation: {required: true, type: "Float", desc: "中心点经度"}
  expose :mian,             documentation: {required: true, type: "Float", desc: "面积"}
  expose :distance,             documentation: {required: true, type: "Integer", desc: "距离站区位置"}
  expose :station_id, documentation: {requiree:true, type:"Integer", desc:"站点id"} do |instance|
    instance.station.try(:id)
  end
  expose :commission_id, documentation: {requiree:true, type:"Integer", desc:"提成id"} do |instance|
    instance.commission.try(:id)
  end
  expose :commission_name, documentation: {requiree:true, type:"Integer", desc:"提成id"} do |instance|
    instance.commission.try(:name)
  end
  expose :commission_price, documentation: {requiree:true, type:"Integer", desc:"提成id"} do |instance|
    instance.commission.try(:price)
  end
  expose :points, using: PointEntity 
  # expose :points, using: PointEntity
end
