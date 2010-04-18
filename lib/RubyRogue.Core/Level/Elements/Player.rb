# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core::Elements
  class Player


    attr_reader :inventory, :gold
    
    def initialize
      @inventory = []
      @gold = rand(30)
    end

    def fill?
      return false
    end

    def collide(element)
      if element.kind_of? Door
        element.open
      end
    end

    def overlap(element)
      if element.class == Item || element.class == Gold
        if element.class == Item
          @inventory << element
        end
        if element.class == Gold
          @gold += element.value
        end
        return true
      else
        return false
      end
    end

   




    def symbol
      return self.class
    end

  end
end
