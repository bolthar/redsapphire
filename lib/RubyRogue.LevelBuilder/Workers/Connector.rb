# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers

    class Connector

      def connect!(alreadyConnected,toConnect,direction)

        tempZone = Zone.merge(alreadyConnected,toConnect,direction)        
        startPoint = nil
        endPoint = nil
        for x in 0...tempZone.width
          for y in 0...tempZone.height
            startPoint = Position.new(x,y) if tempZone.at(x,y).equal?alreadyConnected.at(alreadyConnected.center)
            endPoint = Position.new(x,y) if tempZone.at(x,y).equal?toConnect.at(toConnect.center)
            break if startPoint && endPoint
          end
        end
        #determine curve point
        longSide = nil
        shortSide = nil
        if direction == Direction.Up || direction == Direction.Down
         longSide = startPoint.yOffset(endPoint).abs
         shortSide = startPoint.xOffset(endPoint)
        else
         longSide = startPoint.xOffset(endPoint).abs
         shortSide = startPoint.yOffset(endPoint)
        end
        firstPiece = 1 + rand(longSide)
        secondPiece = shortSide.abs
        thirdPiece = longSide - firstPiece        
        startPoint = digCorridor!(tempZone, startPoint, direction, firstPiece)
        if shortSide > 0
          startPoint = digCorridor!(tempZone, startPoint, direction.cardinalRight,secondPiece.abs)
        end
        if shortSide < 0
          startPoint = digCorridor!(tempZone, startPoint, direction.cardinalRight, secondPiece.abs)
        end
        startPoint = digCorridor!(tempZone, startPoint, direction, thirdPiece)
      end

      private
      def digCorridor!(zone, startPoint, direction, length)
        length.times do          
          startPoint = startPoint.move!(direction)
          zone.at(startPoint).clear
        end
        return startPoint
      end

    end

  end
end
