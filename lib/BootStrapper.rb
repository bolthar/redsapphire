
require 'Headers.rb'

include LevelBuilder
include LevelBuilder::Workers
include Core::Elements
include SDLWrapper

registry = Needle::Registry.new do |reg|
  reg.register(:levelFiller) { LevelFiller.new }
  reg.register(:splitter) { Splitter.new }
  reg.register(:roomDigger) { RoomDigger.new }
  reg.register(:connector) { Connector.new() }
end

srand(Date.new.hash)
adapter = SDLadapter.new
dumper = SDLdumper.new
dumper.startup(9,15,100,50)
5.times do
architect = Architect.new(100,50,registry)
level = architect.build()
level.do_fov(51,20,8)
dumpedLevel = adapter.convert(level)
dumper.render(dumpedLevel,9,15)
sleep(5)
end
