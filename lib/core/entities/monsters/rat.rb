
class Rat < Monster

  def initialize(owner)
    super(owner)
    @hp = rand(10)
    
  end
  
  def fill?
    return true
  end

  def hit(target)
    return 1
  end

  def name
    return "the rat"
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
    x = rand(3) - 1
    y = rand(3) - 1
    target = self.owner.pan(x, y)
    move(target)
  end


end