# To change this template, choose Tools | Templates
# and open the template in the editor.

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
       return true if self.y == target.y if self.x == target.x
       return false
    end

    def xOffset(target)
      return target.x - self.x
    end

    def yOffset(target)
      return target.y - self.y
    end

    def move!(direction)
      return Position.new(self.x + direction.x,self.y + direction.y)
    end

  end

end
