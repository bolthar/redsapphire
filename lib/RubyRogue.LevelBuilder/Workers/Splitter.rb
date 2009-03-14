# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers
    
  class Splitter
    

    def split(level,rows, columns)
      #level width and height must be divisible by rows and columns
      raise "invalid number of rows" unless level.width.remainder(rows) == 0
      raise "invalid number of columns" unless level.height.remainder(columns) == 0

      rowWidth = (level.width / rows).to_i
      columnWidth = (level.height / columns).to_i

      resultZones = []
      for xZone in 0...rows
        resultZones[xZone] = []
        for yZone in 0...columns
          xFrom = xZone * rowWidth
          xTo = xFrom + rowWidth
          yFrom = yZone * columnWidth
          yTo = yFrom + columnWidth
          resultZones[xZone][yZone] = Zone.new(level,xFrom, xTo, yFrom, yTo)
        end
      end
      return resultZones
    end

  end
  
end

end
