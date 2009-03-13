# To change this template, choose Tools | Templates
# and open the template in the editor.


module Core
class Cell < Array
  

  def <<(item)
    raise "Added items must respond to rules" unless item.respond_to?(:rules)

    super(item)
    return true
  end

end

end