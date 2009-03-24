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
        if thirdPiece == 0
          firstPiece -= 1
          thirdPiece += 1
        end
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
        digCorridor!(tempZone, currentPoint, direction, thirdPiece) if thirdPiece != 0
        putDoor!(tempZone,startPoint)
        putDoor!(tempZone,endPoint)
        toConnect.connect  
      end

      private
      def digCorridor!(zone, startPoint, direction, length)
        length.times do          
          startPoint = startPoint.move(direction)         
          zone.at(startPoint).clear
          end
        return startPoint
      end

      def putDoor!(zone,point)
        zone.at(point.x,point.y).clear
        zone.at(point.x,point.y) << Door.new  if doorHereIsOkay(zone,point)
      end

      def getGoodLocation(zone, target, direction)
       
        #get empty cells         
        goodCells = target.getCells { |cell| cell.count == 0 }        
        targetCell = goodCells[rand(goodCells.count)]
        targetPosition = zone.getPosition(targetCell)
        while(zone.at(targetPosition).count == 0)
          targetPosition = targetPosition.move(direction)
        end        
        return targetPosition
      end

      def doorHereIsOkay(zone,point)
        #start at right
        direction = Direction.Right
        count = 0
        4.times do
          3.times do
            cell = zone.at(point.move(direction))
            if cell && cell.count == 0
             count += 1
            end
            direction = direction.right
          end
          direction = direction.left
          return false if count == 3
          count = 0
        end
        return true
      end

    end
  end
end
