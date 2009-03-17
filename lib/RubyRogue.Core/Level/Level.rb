
module Core
  class Level
    include Accessible

    def initialize(width, height)
      @height = height
      @width = width
      @cells = []
      for x in 0...width
        @cells[x] = []
        for y in 0...height
          @cells[x][y] = Cell.new
        end
      end

    end

    

  end
end
