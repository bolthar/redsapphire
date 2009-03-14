# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core

module LevelBuilder

  class Zone
    include Accessible

    attr_accessor :center

    def initialize(level, rowOffset, rowWidth, columnOffset, columnWidth)
      @width = rowWidth
      @height = columnWidth
      @connected = false
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

    def connected?
      return @connected
    end

    def connect
      raise "cannot connect an already connected zone" unless !@connected
      @connected = true
    end

  end
end
