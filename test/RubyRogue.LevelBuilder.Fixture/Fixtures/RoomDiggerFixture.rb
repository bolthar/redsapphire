# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder
include LevelBuilder::Workers

class RoomDiggerFixture < Test::Unit::TestCase

  def test_buildFeature_widthandHeight_digCorrectNoOfCells
    builder = RoomDigger.new
    level = Level.new(100,100)
    zone = Zone.new(level,0,20,0,20)
    for x in 0...zone.width
      for y in 0...zone.height
         zone.at(x,y) << Wall.new
      end
    end
    builder.buildFeature!(zone,1,1,2,5)
    emptyCellsCount = 0   
    for x in 0...zone.width
      for y in 0...zone.height
        emptyCellsCount += 1 if zone.at(x,y).count == 0        
      end
    end
    assert(emptyCellsCount == 10)    
  end

  def test_buildFeature_xandy_digRoomAtRightPlace
    builder = RoomDigger.new
    level = Level.new(100,100)
    zone = Zone.new(level,0,20,0,20)
    for x in 0...zone.width
      for y in 0...zone.height
         zone.at(x,y) << Wall.new
      end
    end
    builder.buildFeature!(zone,1,1,5,2)
    assert(zone.at(5,2).count == 0)
  end

  def test_buildFeature_squareRoom_assignCenterSomewhereInsideRoom
    builder = RoomDigger.new
    level = Level.new(100,100)
    zone = Zone.new(level,0,20,0,20)
    for x in 0...zone.width
      for y in 0...zone.height
         zone.at(x,y) << Wall.new
      end
    end
    builder.buildFeature!(zone,1,1,5,2)
    assert(zone.at(zone.center).count == 0)
  end

end


