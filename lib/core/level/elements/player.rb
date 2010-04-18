
module Core::Elements
  class Player

    attr_reader :gold
    
    def initialize
      @gold = rand(30)
    end

    def fill?
      return false
    end

    def collide(element)
      if element.kind_of? Door
        element.open
      end
      if element.kind_of? Monster
        element.take_damage
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
