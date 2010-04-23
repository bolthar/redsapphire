
class Level
  include Enumerable
  include LineOfSight
  include FieldOfView
  include AStar

  attr_reader :width, :height
  attr_reader :objects
  attr_reader :messages
  
  def initialize(width, height)
    @height = height
    @width = width
    @messages = []
    @objects = []
    @cells = []
    for x in 0...width
      @cells[x] = []
      for y in 0...height
        @cells[x][y] = Cell.new(self, x, y)
      end
    end
  end

  def player
    each do |cell|
      cell.each do |element|
        return element if element.kind_of? Player
      end
    end
  end

  def do_turn
    @objects.delete_if { |obj| obj.owner == nil}
    @objects.each do |obj|
      obj.turn_passed
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
    return @cells[x][y] if x.between?(0, @width - 1) && y.between?(0, @height - 1)
    return Cell.out_of_bounds
  end

end