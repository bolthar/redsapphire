
require 'Headers.rb'

include LevelBuilder
include LevelBuilder::Workers
include Core
include Core::Elements
include SDLWrapper

x = 100
y = 50
w = 9
h = 15

registry = Needle::Registry.new do |reg|
    reg.register(:levelFiller) { LevelFiller.new }
    reg.register(:splitter) { Splitter.new }
    reg.register(:roomDigger) { RoomDigger.new }
    reg.register(:connector) { Connector.new }
    reg.register(:architect) { Architect.new(x,y,registry) }
    reg.registry(:eventHandler) { SDLeventHandler.new }
    reg.registry(:adapter) { SDLadapter.new }
    reg.registry(:dumper) do
      dumper = SDLdumper.new
      dumper.startup(w,h,x,y)
      dumper
    end

end


srand(Date.new.hash)
mediator = Mediator.new(registry)
mediator.start

