# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core

module LevelBuilder

  class Zone
    include Enumerable
    
    attr_accessor :center
    attr_reader :level, :xOffset, :yOffset
    attr_reader :width, :height

    def initialize(level, xFrom, xTo, yFrom, yTo)
      @level = level
      @width = xTo-xFrom
      @height = yTo-yFrom
      @xOffset = xFrom
      @yOffset = yFrom
      @connected = false
      @cells = []
      for x in 0...(xTo-xFrom)
        @cells[x] = []
        for y in 0...(yTo-yFrom)
          xLocation = xFrom+x
          yLocation = yFrom+y
          @cells[x][y] = level[xLocation, yLocation]
        end
      end
    end

    def [](x, y)
      return @cells[x][y]
    end

    def each
      @cells.each do |line|
        line.each do |cell|
          yield(cell)
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
      zoneXfrom = -1
      zoneXto = -1
      zoneYfrom = -1
      zoneYto = -1

      if direction == Direction.Up
        zoneXfrom = zoneOne.xOffset
        zoneXto = zoneOne.xOffset + zoneOne.width
        zoneYfrom = zoneTwo.yOffset
        zoneYto = zoneTwo.yOffset + zoneTwo.height + zoneOne.height
      end

      if direction == Direction.Right
        zoneXfrom = zoneOne.xOffset
        zoneXto = zoneOne.xOffset + zoneOne.width + zoneTwo.width
        zoneYfrom = zoneOne.yOffset
        zoneYto = zoneOne.yOffset + zoneOne.height
      end

      if direction == Direction.Left
        zoneXfrom = zoneTwo.xOffset
        zoneXto =  zoneTwo.xOffset + zoneOne.width + zoneTwo.width
        zoneYfrom = zoneOne.yOffset
        zoneYto = zoneOne.yOffset + zoneOne.height
      end

       if direction == Direction.Down
        zoneXfrom = zoneOne.xOffset
        zoneXto = zoneOne.xOffset + zoneOne.width
        zoneYfrom = zoneOne.yOffset
        zoneYto = zoneOne.yOffset + zoneTwo.height + zoneOne.height
      end

      return Zone.new(level,zoneXfrom, zoneXto, zoneYfrom, zoneYto)
    end

    def hasCell? (cell)
      for x in 0...width
        for y in 0...height
          return true if cell.equal?self.at(x,y)
        end
      end
      return false
    end

    def getPosition(cell)
      for x in 0...width
        for y in 0...height
          return Position.new(x,y) if self[x,y].equal?(cell)
        end
      end
      return nil
    end





  end
end
