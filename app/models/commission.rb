class Commission < ActiveRecord::Base
  validates :name,:price  ,presence: true
end
