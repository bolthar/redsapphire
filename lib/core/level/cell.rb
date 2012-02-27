
class Cell
  include Enumerable

  attr_reader :x, :y, :level

  def initialize(level, x, y)
    @level = level
    @x     = x
    @y     = y
  end

  def self.out_of_bounds
    @oob = OutOfBounds.new
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
    return false if empty?
    return @elements.any? { |el| el.fill? }
  end

  def can_see_through?
    return true if empty?
    return @elements.all? { |el| el.can_see_through? }
  end

  def first
    return elements.first
  end

  def empty?
    return elements.empty?
  end
  
  def each(&block)
    return elements.each(&block)
  end

  def invalidate
    @elements = nil
  end

  def add_message(message)
    @level.messages << message
  end

  def level
    return @level
  end
  
  private
  def elements
    @elements = @level.objects.select do |entity|
      entity.owner == self
    end unless @elements
    return @elements
  end

end
