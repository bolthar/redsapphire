
class Player < Entity

  def fill?
    return true
  end

  def move(destination)
    unless destination.blocked?
      self.owner = destination
    else
      damage = rand(2)
      message "you hit the #{destination.first.class.to_s} for #{damage} damage"
      destination.first.do_damage(damage)
    end
  end

end