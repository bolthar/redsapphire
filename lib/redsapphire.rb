
require File.dirname(__FILE__) + '/headers.rb'

def move(player, destination)
  player.move(destination)
end

srand(Time.now.hash)

level = SimpleLayout.new.build(80, 40)

player = Player.new(level[11,4])
level.objects << player

level.objects << Plant.new(level[20,5])
level.objects << Plant.new(level[21,4])
#level.objects << Rat.new(level[17,6])
#level.objects << Goblin.new(level[18,6])
#level.objects << Goblin.new(level[19,6])
level.objects << Goblin.new(level[19,5])
level.objects << Troll.new(level[15,5])

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

