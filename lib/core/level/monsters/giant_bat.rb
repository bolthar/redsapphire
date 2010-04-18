
class GiantBat < Monster

  def initialize
    @hp = rand(6) + 1
  end

  def fill?
    return true
  end

  def symbol
    return self.class
  end

end