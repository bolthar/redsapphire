# To change this template, choose Tools | Templates
# and open the template in the editor.
include Core::Elements

module LevelBuilder
  module Workers

    class LevelFiller

      def fillLevel!(level)
        level.each do |cell|
          cell << Wall.new
        end
      end

    end
  end
end
