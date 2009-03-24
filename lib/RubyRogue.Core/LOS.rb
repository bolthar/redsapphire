# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  module LOS

def get_line(source,target)

  x0 = self.getPosition(source).x
  x1 = self.getPosition(target).x
  y0 = self.getPosition(source).y
  y1 = self.getPosition(target).y
  cells = []
  cells.extend Queryable
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
      cells << self.at(y,x)
    else
      cells << self.at(x,y)
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
end
