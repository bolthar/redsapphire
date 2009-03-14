# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder

class ArchitectFixture < Test::Unit::TestCase

 def test_architect_buildLevel_doNotRaise
   registry = Needle::Registry.new do |r|
     r.register(:levelFiller) { LevelFiller.new }
     r.register(:splitter) { Splitter.new }
     r.register(:roomDigger) { RoomDigger.new }
     r.register(:connector) { Connector.new }
   end
   architect = Architect.new(100,100,registry)
   level = architect.build

 end

end
