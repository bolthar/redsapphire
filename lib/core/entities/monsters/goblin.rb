
class Goblin < Monster

  def initialize
    super
    @sleeping = true
    @hp = rand(8) + 4
  end

  def fill?
    return true
  end

  def hit(target)
    return 1
  end

  def name
    return "the goblin"
  end

  def turn_passed
    if !@field_of_view
      @field_of_view = self.owner.level.get_fov(self, 5)
    end
    @field_of_view = self.owner.level.get_fov(self, 5) unless @sleeping
    if @hp > 2
      if(@field_of_view.include?(self.owner.level.player.owner)) 
        @sleeping = false
        target = self.owner.level.get_shortest_path(self.owner, self.owner.level.player.owner)[1]
      end
    else
      target = get_fleeing_target(self.owner.level.player.owner)
    end
    move(target) if target    
  end

  def get_fleeing_target(player_cell)
    delta_x = self.owner.x - player_cell.x
    delta_y = self.owner.y - player_cell.y
    possible_targets = []
    if delta_x.abs >= delta_y.abs
      (-1..1).each do |y|
        possible_targets << self.owner.level[self.owner.x + 1, self.owner.y + y]
      end
    end
    if delta_x.abs <= delta_y.abs
      (-1..1).each do |x|
        possible_targets << self.owner.level[self.owner.x + x, self.owner.y + 1]
      end
    end
    valid_targets = possible_targets.select { |tgt| !tgt.blocked? }
    return valid_targets[rand(valid_targets.length)]
  end

end
