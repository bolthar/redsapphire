# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers

    class Connector

      def connect!(alreadyConnected,toConnect,direction)
        currentPosition = alreadyConnected.center
        inOtherZone = false
        while(currentPosition != toConnect.center)
          unless currentPosition.move!(direction)

          end

        end



      end





      
    end

  end
end
