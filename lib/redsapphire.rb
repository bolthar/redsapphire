
require 'headers.rb'

def move(player, destination)
  player.move(destination)
end

srand(Time.now.hash)

level = Level.new(30, 15)
level.each do |cell|
  unless (cell.x > 10 && cell.x < 22) && (cell.y > 3 && cell.y < 13)
    level.objects << Wall.new(cell)
  end
end

cell = level.select { |cell| cell.empty? }.first
player = Player.new(cell)
level.objects << player

level.objects << Plant.new(level[20,11])
level.objects << Plant.new(level[21,9])
level.objects << Rat.new(level[17,10])

commands = CommandSet.new(level)
adapter = SdlAdapter.new
event_handler = SdlEventHandler.new
adapter.startup
while(true)
  level.do_fov(player.x, player.y, 7)
  adapter.render(level)
  commands.handle(event_handler.get_input)
  level.do_turn
end

