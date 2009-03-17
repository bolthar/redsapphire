# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers

    class Connector

      def connect!(alreadyConnected,toConnect,direction)        
        tempZone = Zone.merge(alreadyConnected,toConnect,direction)
        #get start and end point
        startPoint = getGoodLocation(tempZone,alreadyConnected,direction)
        endPoint = getGoodLocation(tempZone,toConnect,direction.opposite)
        #p "direction #{direction.x},#{direction.y}"
        #p "start point #{startPoint.x}, #{startPoint.y}"
        #p "end point #{endPoint.x}, #{endPoint.y}"
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
        currentPoint = digCorridor!(tempZone, startPoint, direction, firstPiece)
        if direction == Direction.Up || direction == Direction.Right
          if shortSide > 0
           currentPoint = digCorridor!(tempZone, currentPoint, direction.cardinalRight,secondPiece.abs)
          end
          if shortSide < 0
           currentPoint = digCorridor!(tempZone, currentPoint, direction.cardinalLeft, secondPiece.abs)
          end
        else
          if shortSide > 0
           currentPoint = digCorridor!(tempZone, currentPoint, direction.cardinalLeft,secondPiece.abs)
          end
          if shortSide < 0
           currentPoint = digCorridor!(tempZone, currentPoint, direction.cardinalRight, secondPiece.abs)
          end
        end        
        digCorridor!(tempZone, currentPoint, direction, thirdPiece)
        putDoor!(tempZone,startPoint)
        putDoor!(tempZone,endPoint)
        toConnect.connect  
      end

      private
      def digCorridor!(zone, startPoint, direction, length)
        length.times do
          #p startPoint
          startPoint = startPoint.move(direction)         
          zone.at(startPoint).clear
          end
        return startPoint
      end

      def putDoor!(zone,point)
        zone.at(point.x,point.y).clear
        zone.at(point.x,point.y) << Door.new
      end

      def getGoodLocation(zone, target, direction)
        p "enter"
        #get empty cells         
        goodCells = target.getCells { |cell| cell.count == 0 }
        p "got cells"
        targetCell = goodCells[rand(goodCells.count)]
        targetPosition = zone.getPosition(targetCell)
        while(zone.at(targetPosition).count == 0)
          targetPosition = targetPosition.move(direction)
        end
        p targetPosition
        return targetPosition
      end
    end
  end
end
