
class Monster < Entity

  attr_reader :hp
  def initialize
    super
    @actions = {}
    @actions[Player] = Attack.new
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
      destination << self
      destination.each do |entity|
        self.interact_with(entity)
      end
    else
      self.interact_with(destination.first)
    end
  end
  
  def fill?
    return true
  end

  def can_see_through?
    return true
  end
  
end
