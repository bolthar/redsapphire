module FOV
  # Multipliers for transforming coordinates into other octants
  @@mult = [
              [1,  0,  0, -1, -1,  0,  0,  1],
              [0,  1, -1,  0,  0, -1,  1,  0],
              [0,  1,  1,  0,  0, -1, -1,  0],
              [1,  0,  0,  1, -1,  0,  0, -1],
           ]

  # Determines which co-ordinates on a 2D grid are visible
  # from a particular co-ordinate.
  # start_x, start_y: center of view
  # radius: how far field of view extends
  def do_fov(start_x, start_y, radius)
      self.each { |cell| cell.lights_off}
      self[start_x, start_y].light
      8.times do |oct|
          cast_light start_x, start_y, 1, 1.0, 0.0, radius,
              @@mult[0][oct],@@mult[1][oct],
              @@mult[2][oct], @@mult[3][oct], 0
      end
  end

  private
  # Recursive light-casting function
  def cast_light(cx, cy, row, light_start, light_end, radius, xx, xy, yx, yy, id)
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
          light(mx, my) if (dx*dx + dy*dy) < radius_sq
          if blocked
            # We've scanning a row of blocked squares
            if self[mx, my].blocked?
              new_start = r_slope
              next
            else
              blocked = false
              light_start = new_start
            end
          else
            if self[mx, my].blocked? and j < radius
              # This is a blocking square, start a child scan
              blocked = true
              cast_light(cx, cy, j+1, light_start, l_slope,
                         radius, xx, xy, yx, yy, id+1)
              new_start = r_slope
            end
          end
        end
      end # while dx <= 0
      break if blocked
    end # (row..radius+1).each
  end

end