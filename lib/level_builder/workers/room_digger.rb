# To change this template, choose Tools | Templates
# and open the template in the editor.

module LevelBuilder
  module Workers

    class RoomDigger

      def buildFeature!(zone,x,y,width,height)
        for xPos in x...(x + width)
          for yPos in y...(y + height)
            zone[xPos,yPos].clear
          end
        end
        #determine zone center
        centerX = (width / 2).to_i + x
        centerY = (height / 2).to_i + y
        zone.center = Position.new(centerX,centerY)
        return true
      end
    end

  end
end
