class Commission < ActiveRecord::Base
  validates :name,:price  ,presence: true
  has_many :areas
end
