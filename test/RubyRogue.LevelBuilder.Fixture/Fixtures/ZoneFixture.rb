# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder
include LevelBuilder::Workers
include Core

class ZoneFixture < Test::Unit::TestCase

  def test_ctor_always_createCorrectZone
    level = Level.new(100,100)
    zone = Zone.new(level,60,80,40,60)
    assert(zone.at(14,2).equal?level.at(74,42))
  end

  def test_height_returnCorrectValue
    level = Level.new(100,100)
    zone = Zone.new(level,0,20,20,45)
    assert(zone.height == 25)
  end

  def test_width_returnCorrectValue
    level = Level.new(100,100)
    zone = Zone.new(level,0,25,0,20)
    assert(zone.width == 25)
  end

  def test_center_getAndSetWorking
    level = Level.new(100,100)
    zone = Zone.new(level,3,25,3,20)
    zone.center = Position.new(5,5)
    assert(zone.center == Position.new(5,5))
  end

  def test_ctor_connected_always_false
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,2,20)
    assert(!zone.connected?)
  end

  def test_ctor_connect_turnConnectedToTrue
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,2,20)
    zone.connect
    assert(zone.connected?)
  end

  def test_ctor_connect_cannotconnectTwice
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,2,20)
    zone.connect
    assert_raise RuntimeError do
      zone.connect
    end    
  end

  def test_ctor_always_assignLevel
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,2,20)
    assert(level == zone.level)
  end

  def test_merge_notCardinalDirection_raise
    level = Level.new(100,100)
    zoneOne = Zone.new(level,0,20,0,20)
    zoneTwo = Zone.new(level,0,20,1,20)
    assert_raise RuntimeError do
      Zone.merge(zoneOne,zoneTwo,Direction.DownLeft)
    end

  end

  def test_merge_down_returnNewZone
    level = Level.new(100,100)
    zoneOne = Zone.new(level,0,20,0,20)
    zoneTwo = Zone.new(level,0,20,20,40)
    newZone = Zone.merge(zoneOne,zoneTwo,Direction.Down)
    assert(newZone.level == zoneOne.level)
    assert(newZone.width == 20)
    assert(newZone.height == 40)
    assert(newZone.at(2,2).equal?zoneOne.at(2,2))
    assert(newZone.at(2,22).equal?zoneTwo.at(2,2))
  end

  def test_merge_right_returnNewZone
    level = Level.new(100,100)
    zoneOne = Zone.new(level,0,20,0,20)
    zoneTwo = Zone.new(level,20,40,0,20)
    newZone = Zone.merge(zoneOne,zoneTwo,Direction.Right)
    assert(newZone.level == zoneOne.level)
    assert(newZone.width == 40)
    assert(newZone.height == 20)
    assert(newZone.at(2,2).equal?zoneOne.at(2,2))
    assert(newZone.at(29,5).equal?zoneTwo.at(9,5))
  end

  def test_merge_up_returnNewZone
    level = Level.new(100,100)
    zoneOne = Zone.new(level,0,20,20,40)
    zoneTwo = Zone.new(level,0,20,0,20)
    newZone = Zone.merge(zoneOne,zoneTwo,Direction.Up)
    assert(newZone.level == zoneOne.level)
    assert(newZone.width == 20)
    assert(newZone.height == 40)
    assert(newZone.at(12,26).equal?zoneOne.at(12,6))
    assert(newZone.at(2,5).equal?zoneTwo.at(2,5))
  end

  def test_merge_inbetween_returnNewZone
    level = Level.new(100,100)
    zoneOne = Zone.new(level,60,80,20,40)
    zoneTwo = Zone.new(level,60,80,40,60)
    newZone = Zone.merge(zoneOne,zoneTwo,Direction.Down)
    assert(newZone.level == zoneOne.level)
    assert(newZone.width == 20)
    assert(newZone.height == 40)
    assert(newZone.at(4,18).equal?zoneOne.at(4,18))
    assert(newZone.at(12,33).equal?zoneTwo.at(12,13))
  end

  def test_merge_left_returnNewZone
    level = Level.new(100,100)
    zoneOne = Zone.new(level,20,40,0,20)
    zoneTwo = Zone.new(level,0,20,0,20)
    newZone = Zone.merge(zoneOne,zoneTwo,Direction.Left)
    assert(newZone.level == zoneOne.level)
    assert(newZone.width == 40)
    assert(newZone.height == 20)
    assert(newZone.at(33,10).equal?zoneOne.at(13,10))
    assert(newZone.at(6,2).equal?zoneTwo.at(6,2))
  end

  def test_hasCell_cellIsNotIntoZone_returnFalse
    level = Level.new(100,100)
    zone = Zone.new(level,20,40,0,20)
    cell = Cell.new
    assert(!zone.hasCell?(cell))
  end

  def test_hasCell_cellIsIntoZone_returnFalse
    level = Level.new(100,100)
    zone = Zone.new(level,20,40,0,20)
    cell = zone.at(4,5)
    assert(zone.hasCell?(cell))
  end

  def test_getPosition_cellNotInZone_returnFalse
    level = Level.new(100,100)
    zone = Zone.new(level,20,40,0,20)
    cell = Cell.new
    assert(!zone.getPosition(cell))
  end

  def test_getPosition_cellInZone_returnCorrectPosition
    level = Level.new(100,100)
    zone = Zone.new(level,20,40,0,20)
    cell = zone.at(12,3)
    assert(zone.getPosition(cell) == Position.new(12,3))
  end

  def test_getCells_emptyCondition_returnsOnlyEmptyCells
    level = Level.new(100,100)
    zone = Zone.new(level,20,40,0,20)
    zone.at(1,3) << Wall.new
    zone.at(4,1) << Wall.new
    cells = zone.getCells { |cell| cell.count == 0}    
    assert(cells.count == 398)
  end



end
