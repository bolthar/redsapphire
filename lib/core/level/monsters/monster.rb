
class Monster

  def fill?
    return true
  end

  def when_dead(&block)
    @dead = lambda &block
  end

  def symbol
    return self.class
  end

  def take_damage
    @hp -= 1
    p @hp
    @dead.call if @hp == 0
  end

end