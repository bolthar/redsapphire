# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core::Elements
  class Player

    def fill?
      return false
    end

    def collide(element)
      if element.kind_of? Door
        element.open
      end
    end

    def symbol
      return self.class
    end

  end
end
