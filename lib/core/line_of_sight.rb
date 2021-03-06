
module LineOfSight

  def get_line(source,target)
    x0 = source.x
    x1 = target.x
    y0 = source.y
    y1 = target.y
    cells = []
    steep = ((y1-y0).abs) > ((x1-x0).abs)
    if steep
     x0,y0 = y0,x0
     x1,y1 = y1,x1
    end
    if x0 > x1
     x0,x1 = x1,x0
     y0,y1 = y1,y0
    end
    deltax = x1-x0
    deltay = (y1-y0).abs
    error = (deltax / 2).to_i
    y = y0
    ystep = nil
    if y0 < y1
      ystep = 1
    else
      ystep = -1
    end
    for x in x0..x1
      if steep
        cells << self[y,x]
      else
        cells << self[x,y]
      end
      error -= deltay
      if error < 0
        y += ystep
        error += deltax
      end
    end
    return cells
  end

end