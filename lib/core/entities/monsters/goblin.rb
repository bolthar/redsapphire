
class Goblin < Monster

  def initialize(owner)
    super(owner)
    @hp = rand(8) + 4
    @actions = {}
    @actions[Player] = Attack.new
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

  def get_damage(damage)
    @hp -= damage
    if @hp <= 0
      message "#{name} is dead!"
      destroy
    end
  end

  def move(destination)
    unless destination.blocked?
      self.owner = destination
      destination.each do |entity|
        self.interact_with(entity)
      end
    else
      self.interact_with(destination.first)
    end
  end

  def turn_passed
    if @hp > 2
      target = self.owner.level.get_shortest_path(self.owner, self.owner.level.player.owner)[1]
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