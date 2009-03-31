# To change this template, choose Tools | Templates
# and open the template in the editor.


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
      item.collide(blockingElement) if item.respond_to? :collide
      return false
    else
      self.each do |element|
        result = item.overlap(element) if item.respond_to? :overlap
        self.delete(element) if result
      end
      super(item)
      return true
    end
    
  end

  def light
    @onSight = true
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