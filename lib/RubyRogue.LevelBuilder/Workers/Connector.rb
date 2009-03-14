# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers

    class Connector

      def connect!(alreadyConnected,toConnect,direction)        
        tempZone = Zone.merge(alreadyConnected,toConnect,direction)
        @inFirstRoom = true
        startPoint = nil
        endPoint = nil
        for x in 0...tempZone.width
          for y in 0...tempZone.height
            startPoint = Position.new(x,y) if tempZone.at(x,y).equal?alreadyConnected.at(alreadyConnected.center)
            endPoint = Position.new(x,y) if tempZone.at(x,y).equal?toConnect.at(toConnect.center)
            break if startPoint && endPoint
          end
        end
        p alreadyConnected.center
        p toConnect.center
        p tempZone
        p direction
        p startPoint
        p endPoint
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
          if(@inFirstRoom)
            if(zone.at(startPoint).count != 0)
              @inFirstRoom = false
              zone.at(startPoint).clear
              zone.at(startPoint) << Door.new
            else
              zone.at(startPoint).clear
            end
          else
            if(zone.at(startPoint).count == 0)
              zone.at(startPoint.move!(direction.opposite)) << Door.new #turn back and add door
            end
            zone.at(startPoint).clear
          end         
        end        
        return startPoint
      end

    end

  end
end
