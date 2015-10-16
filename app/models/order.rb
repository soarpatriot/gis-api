class Order < ActiveRecord::Base

  belongs_to :areas 

  enum status: [:success,:no_station,:no_areas,:not_in_areas]

  def increase_for count_type
    if self.send(count_type).nil?
      self.update_column count_type, 1
    else
      self.update_column count_type, self.send(count_type) + 1
    end 
  end


end
