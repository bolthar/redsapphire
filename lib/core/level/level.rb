
class Level
  include Enumerable
  include LOS
  include FOV

  attr_reader :width, :height
  attr_reader :objects

  def initialize(width, height)
    @height = height
    @width = width
    @objects = []
    @cells = []
    for x in 0...width
      @cells[x] = []
      for y in 0...height
        @cells[x][y] = Cell.new(@objects, x, y)
      end
    end
  end

  def each
    @cells.each do |line|
      line.each do |cell|
        yield(cell)
      end
    end
  end

  def [](x, y)
    return @cells[x][y]
  end

end