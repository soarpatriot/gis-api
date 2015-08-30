class PostEntity < Grape::Entity
  expose :id,             documentation: {required: true, type: "Integer", desc: "id"}
  expose :user_id,        documentation: {required: true, type: "Integer", desc:"user id"}
  expose :dream, documentation: {required: true, type: "String", desc:"image url"}
  expose :reality, documentation: {required: true, type: "String", desc:"sound url"}
  expose :percentage, documentation: {required: true, type: "String", desc:"文字内容"}
  
  expose :user_avatar, documentation: {required: true, type: "String", desc:"用户头像"} do |instance|
    instance.user.try(:image_url)
  end
  expose :user_name, documentation: {required: true, type: "String", desc:"用户姓名"} do |instance|
    instance.user.try(:name)
  end

  expose :created_at,       documentation: {required: true, type: "Integer", desc: "创建时间"} do |instance|
       instance.created_at.to_i
  end
  
  expose :voted,       documentation: {required: true, type: "Boolean", desc: "是否投票"} do |instance,options |
       if options[:current_user]
         options[:current_user].voted_up_on? instance
       else
         false 
       end
  end
  
end
