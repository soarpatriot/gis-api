class Point < ActiveRecord::Base
  default_scope {order("id asc")}
  belongs_to :pointable, polymorphic: true
end
