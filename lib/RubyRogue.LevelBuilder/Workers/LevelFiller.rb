# To change this template, choose Tools | Templates
# and open the template in the editor.
include Core::Elements

module LevelBuilder
  module Workers

    class LevelFiller

      def fillLevel!(level)
        for x in 0...level.width
          for y in 0...level.height
            pos = Position.new(x,y)
            level.at(pos) << Wall.new
          end
        end
      end

    end
  end
end
