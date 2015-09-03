class CommissionEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :name,             documentation: {required: true, type: "String", desc: "区域名字"}
  expose :price,             documentation: {required: true, type: "Float", desc: "区域价格"}
end
