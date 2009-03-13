

module Core
  class Level


    def initialize(width, height)
      @height = height
      @width = width
      @cells = []
      for x in 0..width
        @cells[x] = []
        for y in 0..height
          @cells[x][y] = Cell.new
        end
      end

    end

    def height
      return @height
    end

    def width
      return @width
    end

    def at(x,y)
      raise "width is out of bounds" unless x < width
      raise "height is out of bounds" unless y < height

      return @cells[x][y]
      
    end

  end
end
