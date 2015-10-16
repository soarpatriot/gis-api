class Area < ActiveRecord::Base
  
  belongs_to :station
  belongs_to :commission
  has_many :orders
  has_many :points, as: :pointable, dependent: :destroy

  def include_point? point 
    px = point[:lantitude] 
    py = point[:longitude] 
    flag = false 
    on = false  

    points = self.points  
    i = 0
    l = points.size
    j = l - 1 
    while i < l do 
      sx = points[i].lantitude 
      sy = points[i].longitude  
      tx = points[j].lantitude 
      ty = points[j].longitude  

      if((sx == px && sy == py) || (tx == px && ty == py))
        on = true  
        break 
      end
      if((sy < py && ty >= py) || (sy >= py && ty < py))
        x = sx + (py - sy) * (tx - sx) / (ty - sy)
        if x == px 
          on = true 
          break 
        end

        if x > px 
          flag = !flag 
        end
      end
      j = i 
      i = i + 1
    end
    
    if on 
      return on
    end  
    flag
  end
end
