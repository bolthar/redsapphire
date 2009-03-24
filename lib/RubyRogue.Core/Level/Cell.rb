# To change this template, choose Tools | Templates
# and open the template in the editor.


module Core
class Cell < Array

  def <<(item)
    raise "Item added must respond to method 'fill?'" unless item.respond_to? :fill?
    
    return false if self.blocked?
    super(item)
    return true
  end

  def light
    @onSight = true
  end

  def onSight?
    return @onSight
  end

  def blocked?
    self.each { |element|
      return true if element.fill?
      }
    return false
  end
 

end

end