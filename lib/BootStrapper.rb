
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

