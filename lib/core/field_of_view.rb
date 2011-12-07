
#from roguebasin
module FieldOfView
  # Multipliers for transforming coordinates into other octants
  @@mult = [
              [1,  0,  0, -1, -1,  0,  0,  1],
              [0,  1, -1,  0,  0, -1,  1,  0],
              [0,  1,  1,  0,  0, -1, -1,  0],
              [1,  0,  0,  1, -1,  0,  0, -1],
           ]

  def get_fov(entity, radius)
    cells = [self[entity.x, entity.y]]    
    8.times do |oct|
        cast_light entity.x, entity.y, 1, 1.0, 0.0, radius,
            @@mult[0][oct], @@mult[1][oct],
            @@mult[2][oct], @@mult[3][oct], cells
    end    
    entity.field_of_view = cells        
  end

  # Recursive light-casting function
  def cast_light(cx, cy, row, light_start, light_end, radius, xx, xy, yx, yy, cells)
    return if light_start < light_end
    radius_sq = radius * radius
    (row..radius).each do |j| # .. is inclusive
      dx, dy = -j - 1, -j
      blocked = false
      while dx <= 0
        dx += 1
        # Translate the dx, dy co-ordinates into map co-ordinates
        mx, my = cx + dx * xx + dy * xy, cy + dx * yx + dy * yy
        # l_slope and r_slope store the slopes of the left and right
        # extremities of the square we're considering:
        l_slope, r_slope = (dx-0.5)/(dy+0.5), (dx+0.5)/(dy-0.5)
        if light_start < r_slope
          next
        elsif light_end > l_slope
          break
        else
          # Our light beam is touching this square; light it
          if (dx*dx + dy*dy) < radius_sq
            cells << self[mx, my]
          end  
          if blocked
            # We've scanning a row of blocked squares
            if !self[mx, my].can_see_through?
              new_start = r_slope
              next
            else
              blocked = false
              light_start = new_start
            end
          else
            if !self[mx, my].can_see_through? and j < radius
              # This is a blocking square, start a child scan
              blocked = true
              cast_light(cx, cy, j+1, light_start, l_slope,
                         radius, xx, xy, yx, yy, cells)
              new_start = r_slope
            end
          end
        end
      end # while dx <= 0
      break if blocked
    end # (row..radius+1).each
  end

end
