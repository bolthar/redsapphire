

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


  class Door

      def initialize
        @state = DoorClosed.new
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
