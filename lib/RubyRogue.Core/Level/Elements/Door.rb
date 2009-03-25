

module Core::Elements
  
  class DoorClosed
      def fill?
        return true
      end
    end

    class DoorOpen
      def fill?
        return false
      end
    end

    class DoorSecret
      def fill?
        return true
      end
    end

  class Door < Element
    
    
      def initialize
        value = rand(8)
        @state = DoorClosed.new if value < 7
        @state = DoorSecret.new if value == 7
      end

      def fill?
        return @state.fill?
      end

      def open
        @state = DoorOpen.new
      end

      def close
        @state = DoorClosed.new
      end

      def symbol
        return @state.class
      end

      def itemCollided(item)
        self.open if item.kind_of? Player
      end


  end

end
