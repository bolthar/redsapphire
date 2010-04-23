
class Goblin < Monster

  def initialize(owner)
    super(owner)
    @hp = rand(20)
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
    target = self.owner.level.get_shortest_path(self.owner, self.owner.level.player.owner)
    move(target[1]) if target[1]
  end

end