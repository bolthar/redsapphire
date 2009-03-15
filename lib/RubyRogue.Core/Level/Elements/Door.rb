

module Core::Elements
  
  class DoorClosed
    
    def fill?
      return true      
    end    
    
  end
  
  class DoorOpened
    
    def fill? 
      return false
    end
    
  end

  class DoorSecret
    def fill?
      return true
    end
  end


  class Door

      def initialize
        value = rand(8)
        @state = DoorClosed.new if value < 7
        @state = DoorSecret.new if value == 7
      end

      def fill?
        return @state.fill?
      end

      def open
        @state = DoorOpened.new
      end

      def close
        @state = DoorClosed.new
      end
      

  end

end
