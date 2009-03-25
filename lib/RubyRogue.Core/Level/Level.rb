
module Core
  class Level
    include Accessible
    include LOS
    include FOV

    def initialize(width, height)
      @height = height
      @width = width
      @cells = []
      for x in 0...width
        @cells[x] = []
        for y in 0...height
          @cells[x][y] = Cell.new(self,x,y)
        end
      end
    end

    def light(x,y)
      self.at(x,y).light
    end

    def blocked?(x,y)
      return self.at(x,y).blocked?
    end
    

  end
end
