# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core

module LevelBuilder

  class Zone
    include Accessible
    
    attr_reader :width, :height

    def initialize(level, rowOffset, rowWidth, columnOffset, columnWidth)
      @width = rowWidth
      @height = columnWidth
      @cells = []
      for x in 0...rowWidth
        @cells[x] = []
        for y in 0...columnWidth
          xLocation = (rowOffset*rowWidth)+x
          yLocation = (columnOffset*columnWidth)+y
          @cells[x][y] = level.at(xLocation,yLocation)
        end
      end
    end

  end
end
