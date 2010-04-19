
require 'headers.rb'

srand(Time.now.hash)

level = Level.new(30, 15)
level.each do |cell|
  level.objects << Wall.new(cell)
end

adapter = SdlAdapter.new
event_handler = SdlEventHandler.new
adapter.startup
while(true)
  time = Time.now
  adapter.render(level)
  p Time.now - time
end

