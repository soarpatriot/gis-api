class Commission < ActiveRecord::Base
  
  default_scope -> {order(price: :asc)}

  validates :name,:price  ,presence: true
  has_many :areas
end
