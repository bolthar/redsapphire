# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core::Items

module LevelBuilder
  module Workers

    class ItemPopulator

      def populate(level,numberOfItems)
        emptyCells = level.select { |cell| cell.length == 0}
        numberOfItems.times do
          cell = emptyCells[rand(emptyCells.length)]
          cell << Item.new
        end
        20.times do
          cell = emptyCells[rand(emptyCells.length)]
          cell << Gold.new
        end
      end
    end
  end
end
