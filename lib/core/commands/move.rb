
class Move

  def initialize(delta_x, delta_y)
    @delta_x = delta_x
    @delta_y = delta_y
  end

  def execute(level)
    x = level.player.x
    y = level.player.y
    level.player.move(level[x + @delta_x, y + @delta_y])
  end
  
end