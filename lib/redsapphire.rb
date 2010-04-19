
require 'headers.rb'

srand(Time.now.hash)

level = Level.new(50, 25)
level.each do |cell|
  unless (cell.x > 15 && cell.x < 20) && (cell.y > 5 && cell.y < 10)
    level.objects << Wall.new(cell)
  end
end

cell = level.select { |cell| cell.empty? }.first
player = Player.new(cell)
level.objects << player

adapter = SdlAdapter.new
event_handler = SdlEventHandler.new
adapter.startup
event = true
while(event)
  time = Time.now
  level.do_fov(player.x, player.y, 7)
  adapter.render(level)
  p Time.now - time
end

