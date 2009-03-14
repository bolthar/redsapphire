# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core

module LevelBuilder

  class Zone
    include Accessible

    attr_accessor :center
    attr_reader :level, :xOffset, :yOffset

    def initialize(level, rowOffset, rowWidth, columnOffset, columnWidth)
      @level = level
      @width = rowWidth
      @height = columnWidth
      @xOffset = rowOffset
      @yOffset = columnOffset
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

    def Zone.merge(zoneOne,zoneTwo,direction)
      raise "direction must be cardinal" unless direction.isCardinal?
      
      level = zoneOne.level
      zoneWidth = 0
      zoneHeight = 0

      if direction == Direction.Up
        zoneWidth = zoneOne.width
        zoneHeight = zoneOne.height * 2
        zoneXoffset = zoneOne.xOffset
        zoneYoffset = zoneTwo.yOffset
      end

      if direction == Direction.Right
        zoneWidth = zoneOne.width * 2
        zoneHeight = zoneOne.height
        zoneXoffset = zoneOne.xOffset
        zoneYoffset = zoneOne.yOffset
      end

      if direction == Direction.Left
        zoneWidth = zoneOne.width * 2
        zoneHeight = zoneOne.height
        zoneXoffset = zoneTwo.xOffset
        zoneYoffset = zoneOne.yOffset
      end

       if direction == Direction.Down
        zoneWidth = zoneOne.width
        zoneHeight = zoneOne.height * 2
        zoneXoffset = zoneOne.xOffset
        zoneYoffset = zoneOne.yOffset
      end

      return Zone.new(level,zoneXoffset, zoneWidth, zoneYoffset, zoneHeight)
    end



  end
end
