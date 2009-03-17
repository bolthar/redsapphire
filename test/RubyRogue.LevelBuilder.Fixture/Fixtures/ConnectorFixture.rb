# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder::Workers
include Core

class ConnectorFixture < Test::Unit::TestCase

  def test_atleastDoNotRaiseForGodsSake
    connector = Connector.new
    level = Level.new(100,100)
    levelFiller = LevelFiller.new
    levelFiller.fillLevel!(level)
    zoneOne = Zone.new(level, 0,20,0,20)
    zoneTwo = Zone.new(level, 0,20,1,20)
    zone = Zone.merge(zoneOne,zoneTwo, Direction.Down)
    roomDigger = RoomDigger.new
    roomDigger.buildFeature!(zoneOne,2,2,10,10)
    roomDigger.buildFeature!(zoneTwo,4,10,3,3)
    zoneOne.connect
    connector.connect!(zoneOne,zoneTwo,Direction.Down)    
  end
 
end
