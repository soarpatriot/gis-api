class UserEntity < Grape::Entity
  expose :id,            documentation: {required: true, type: "Integer", desc: "user id"}
  expose :mobile_number, documentation: {required: true, type: "String", desc: "mobile number"}
  expose :name,      documentation: {required: true, type: "String"} do |instance, options|
    instance.name.try(:force_encoding, "UTF-8")
  end
  expose :token,      documentation: {required: true, type: "String"} do |instance, options|
    options[:token]
  end
end
