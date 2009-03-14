
require 'Headers.rb'

include LevelBuilder

registry = Needle::Registry.new do |reg|
  reg.register(:mason) { Mason.new }
  reg.register(:corridorDigger) { CorridorDigger.new }
  reg.register(:roomDigger) { RoomDigger.new }
  reg.register(:digger) { Digger.new(reg) }
end

srand(Date.new.hash)
architect = Architect.new(200,200,registry)
level =  architect.build()
for x in 0...200
  for y in 0...200
    if(level.at(x,y).count == 0)
      p "hole at #{x},#{y}"
    end
  end
end
