
module Core

  class Position    

    attr_accessor :x, :y
   
    def initialize(x,y)
      raise "x must be greater than 0" unless x >= 0
      raise "y must be greater than 0" unless y >= 0
      self.x = x
      self.y = y
    end

    def ==(target)
       return self.y == target.y if self.x == target.x
    end

    def xOffset(target)
      return target.x - self.x
    end

    def yOffset(target)
      return target.y - self.y
    end

    def move(direction)
      if self.x + direction.x >= 0 && self.y + direction.y >= 0
        return Position.new(self.x + direction.x,self.y + direction.y)
      end
    end

    def isAdjacent? (target)
      relativeX = (target.x - self.x).abs
      relativeY = (target.y - self.y).abs
      return relativeX < 2 && relativeY < 2 && (relativeX + relativeY != 0)
    end

  end

end
