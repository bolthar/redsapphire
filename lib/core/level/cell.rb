
class Cell
  include Enumerable

  attr_reader :level

  def initialize(objects)
    @objects = objects
  end
 
  def light
    @onSight = true
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
    return true
  end

  def first
    return @objects.first
  end

  def empty?
    return @objects.empty?
  end
  
  def each(&block)
    return @objects.each(&block)
  end

  private
  def elements
    return @objects.select do |entity|
      entity.owner == self
    end
  end

end