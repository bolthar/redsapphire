# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  module Items

    class Item
      def initialize
        
      end

      def fill?
        return false
      end

      def symbol
        return self.class
      end
    end

    class Gold < Item
      
      attr_reader :value

      def initialize
        @value = rand(100)
      end

    end

  end
end
