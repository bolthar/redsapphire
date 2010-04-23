
class Player < Entity

  def initialize(owner)
    super(owner)
    @actions = {}
    @actions[Rat] = Attack.new
    @actions[Goblin] = Attack.new
  end

  def fill?
    return true
  end

  def can_see_through?
    return true
  end

  def name
    return "you"
  end

  def hit(target)
    return rand(3)
  end

  def get_damage(damage)
    #nil
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

end