
class Cell
  include Container

  attr_reader :x, :y, :level

  def initialize(level, x, y)
    @level   = level
    @x       = x
    @y       = y
  end

  def self.out_of_bounds
    @oob ||= OutOfBounds.new
  end

  def pan(delta_x, delta_y)
    return @level[@x - delta_x, @y - delta_y]
  end
 
  def light
    @on_sight = true
    @visited = true
  end

  def visited?
    return @visited
  end

  def lights_off
    @on_sight = false
  end

  def on_sight?
    return @on_sight
  end

  def blocked?
    return false unless @objects.any?
    return @objects.any? { |el| el.fill? }
  end

  def can_see_through?
    return true unless objects.any?
    return @objects.all? { |el| el.can_see_through? }
  end

  def add_message(message)
    @level.messages << message
  end

end
