
class SimpleLayout
  
  def build(width, height)
    @width = width
    @height = height
    @level = Level.new(width, height)
    add_limit_walls()
    20.times do 
      add_room(rand(width), rand(height))
    end
    return @level        
  end
  
  def add_limit_walls()
    @level.select { |cell| cell.x == 0 || cell.x == @width - 1 || cell.y == 0 || cell.y == @height - 1}.each do |cell|
      @level.objects << Wall.new(cell)
    end
  end
  
  def add_room(x, y)
    room_width = rand(12) + 4
    room_height = rand(6) + 4
    return if room_width + x > @width || room_height + y > @height
    borders = @level.select do |cell|
      cell.x.between?(x, x + room_width) && (cell.y == y || cell.y == y + room_height) ||
      cell.y.between?(y, y + room_height) && (cell.x == x || cell.x == x + room_width)      
    end
    borders.each do |cell|
      @level.objects << Wall.new(cell)
    end
    door_cell = borders[rand(borders.count)]
    @level.objects.delete(door_cell.first)   
    door_cell.invalidate
  end
end