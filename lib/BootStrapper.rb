
require 'Headers.rb'


include LevelBuilder
include LevelBuilder::Workers
include Core::Elements

registry = Needle::Registry.new do |reg|
  reg.register(:levelFiller) { LevelFiller.new }
  reg.register(:splitter) { Splitter.new }
  reg.register(:roomDigger) { RoomDigger.new }
  reg.register(:connector) { Connector.new() }
end

srand(Date.new.hash)
architect = Architect.new(150,50,registry)
level =  architect.build()

string = nil
for y in 0...50
  string = ""
  for x in 0...150
     if level.at(x,y).count == 0
       string += "."
     else
       string += "#" if level.at(x,y)[0].kind_of? Wall
       string += "+" if level.at(x,y)[0].kind_of? Door
     end
  end
  p string
end
