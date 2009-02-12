# To change this template, choose Tools | Templates
# and open the template in the editor.


module Core
class Cell
  include Enumerable

  def initialize
    @elements = []
  end

  def each
    @elements.each { |item| yield item }
  end

  def <=>(other)
    @elements <=> other
  end

  def <<(item)
    @elements << item
  end

  def symbol
    result = ""
    @elements.each {|element|
      result = element
    }
    return result

  end
end

end