
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

    def player
      for x in 0...width
        for y in 0...height
          if @cells[x][y].any? { |element| element.kind_of? Player }
           return @cells[x][y].select{ |element| element.kind_of? Player }.first
          end
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
