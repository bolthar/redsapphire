# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder
include LevelBuilder::Workers

class RoomDiggerFixture < Test::Unit::TestCase

  def test_buildFeature_widthandHeight_digCorrectNoOfCells
    builder = RoomDigger.new(2,5,1,1)
    level = Level.new(100,100)
    zone = Zone.new(level,0,20,0,20)
    for x in 0...zone.width
      for y in 0...zone.height
         zone.at(x,y) << Wall.new
      end
    end
    builder.buildFeature!(zone)
    emptyCellsCount = 0
    cellsCount = 0
    for x in 0...zone.width
      for y in 0...zone.height
        emptyCellsCount += 1 if zone.at(x,y).count == 0        
      end
    end
    assert(emptyCellsCount == 10)    
  end
end


