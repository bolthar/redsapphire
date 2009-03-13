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
    raise "Added items must respond to rules" unless item.respond_to?(:rules)

    @elements << item
    return true
  end

end

end