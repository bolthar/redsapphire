# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  module Items
    
    class Item < Entity

      attr_reader :name

      def initialize(owner)
        super(owner)
        @name = (0..5).map { |n| ('a'..'z').to_a[rand(26)] }.join
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
