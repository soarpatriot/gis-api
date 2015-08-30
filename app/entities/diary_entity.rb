class DiaryEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :user_id,        documentation: {required: true, type: "Integer", desc:"user id"}
  expose :post_id,        documentation: {required: true, type: "Integer", desc:"post id"}
  expose :content, documentation: {required: true, type: "String", desc:"文字内容"}
  expose :created_at,     documentation: {required: true, type: "String", desc: "创建时间"}
end
