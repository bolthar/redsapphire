
module Core
class Cell < Array

  def initialize(level,x,y)
    @level = level
    @x = x
    @y = y
  end

  def position
    return Position.new(@x,@y)
  end

  attr_reader :level

  def <<(item)
    raise "Item added must respond to method 'fill?'" unless item.respond_to? :fill?
    blockingElement = self.blocked?
    if blockingElement
      item.collide(blockingElement)
      return false
    else
      self.each do |element|
        item.overlap(element)
      end
      item.
      super(item)
      return true
    end
    
  end



  def light
    @onSight = true
    @visited = true
  end

  def visited?
    return @visited
  end

  def lightsOff
    @onSight = false
  end

  def onSight?
    return @onSight
  end

  def blocked?
    self.each { |element|
      return element if element.fill?
      }
    return false
  end
 

end

end