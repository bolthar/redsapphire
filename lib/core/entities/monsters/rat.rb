
class Rat < Entity

  def initialize(owner)
    super(owner)
    @hp = rand(10)
  end
  
  def fill?
    return true
  end

  def do_damage(damage)
    @hp -= damage
    if @hp <= 0
      message "the rat is dead!"
      destroy
    end
  end

  def turn_passed
    x = rand(3) - 1
    y = rand(3) - 1
    target = self.owner.pan(x, y)
    unless target.blocked?
      self.owner = self.owner.pan(x, y)
    end
  end


end