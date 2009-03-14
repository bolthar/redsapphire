# To change this template, choose Tools | Templates
# and open the template in the editor.


include LevelBuilder
include LevelBuilder::Workers
include Core

class ZoneFixture < Test::Unit::TestCase

  def test_ctor_always_createCorrectZone
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,2,20)
    assert(zone.at(14,2) == level.at(74,52))
  end

  def test_height_returnCorrectValue
    level = Level.new(100,100)
    zone = Zone.new(level,3,20,3,25)
    assert(zone.height == 25)
  end

  def test_width_returnCorrectValue
    level = Level.new(100,100)
    zone = Zone.new(level,3,25,3,20)
    assert(zone.width == 25)
  end

end
