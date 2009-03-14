# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core

  class Direction
    
    attr_reader :x, :y

    #static default directions
    def Direction.Up
      return Direction.new(0,-1)
    end

    def Direction.UpRight
      return Direction.new(1,-1)
    end

    def Direction.Right
      return Direction.new(1,0)
    end

    def Direction.DownRight
      return Direction.new(1,1)
    end

    def Direction.Down
      return Direction.new(0,1)
    end

    def Direction.DownLeft
      return Direction.new(-1,1)
    end

    def Direction.Left
      return Direction.new(-1,0)
    end

    def Direction.UpLeft
      return Direction.new(-1,-1)
    end
  
    def initialize(x,y)
      raise "x must be -1, 0 or 1" if x != 1 if x != 0 if x != -1
      raise "y must be -1, 0 or 1" if y != 1 if y != 0 if y != -1

      @x = x
      @y = y
    end

    def ==(target)
       return true if self.y == target.y if self.x == target.x
       return false
    end

    #fluid interface methods
    def cardinalLeft
      if(self.x == 0)
        #up or down                
        return Direction.new(self.y,0)
      else
        #left or right
         return Direction.new(0,-self.x)
      end
    end

    def cardinalRight
      if(self.x == 0)
        #up or down
        return Direction.new(-self.y,0)
      else
        #left or right
         return Direction.new(0,self.x)
      end
    end

    def opposite
      return Direction.new(-self.x,-self.y)
    end

    def left
      newX = 0
      newY = 0
      if(self.x == 0 || self.y == 0)
        if(self.x == 0)
          newX = self.y
          newY = self.y
        else
          newX = self.x
          newY = -self.x
        end     
      else
        if(self.x + self.y == 0)
          newX = 0
          newY = self.y
        else
          newX = self.x
          newY = 0
        end        
      end
      return Direction.new(newX,newY)
    end

    def right
      newX = 0
      newY = 0
      if(self.x == 0 || self.y == 0)
        if(self.x == 0)
          newX = -self.y
          newY = self.y
        else
          newX = self.x
          newY = self.x
        end
      else
        if(self.x + self.y != 0)
          newX = 0
          newY = self.y
        else
          newX = self.x
          newY = 0
        end
      end
      return Direction.new(newX,newY)
    end

    def isCardinal?
      return (self.x == 0 || self.y == 0)
    end


    
  end

end
