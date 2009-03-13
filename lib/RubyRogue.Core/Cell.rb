# To change this template, choose Tools | Templates
# and open the template in the editor.


module Core
class Cell < Array
  

  def <<(item)
    raise "Item added must respond to method 'fill?'" unless item.respond_to? :fill?
    
    self.each { |element|
      return false if element.fill?
      }
    super(item)
    return true
  end

end

end