
class Level
  include Enumerable
  include LineOfSight
  include FieldOfView
  include AStar

  attr_reader :width, :height
  attr_reader :messages
  
  def initialize(width, height)
    @height = height
    @width = width
    @messages = []
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
    return nil
  end

  def do_turn
    self.objects.each do |obj|
      obj.turn_passed
    end
  end

  def enemies_in_sight
    my_player_fov = self.player.field_of_view
    enemies = []
    self.each do |cell|
      cell.each do |obj|
        enemies << obj if my_player_fov.include?(obj.owner) && obj.kind_of?(Monster)
      end
    end
    enemies.insert(0, self.player)
    return enemies
  end

  def each
    @cells.each do |line|
      line.each do |cell|
        yield(cell)
      end
    end
  end

  def objects
    return self.map { |x| x.objects }.flatten 
  end

  def [](x, y)    
    return @cells[x][y] if x.between?(0, @width - 1) && y.between?(0, @height - 1)
    return Cell.out_of_bounds
  end

end
