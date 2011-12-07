
require 'require_all'
require 'benchmark'

require_all File.join(File.dirname(__FILE__), 'core')
require_all File.join(File.dirname(__FILE__), 'gosu')

def move(player, destination)
  player.move(destination)
end

def get_empty_cell(level) 
  cell = level[rand(level.width), rand(level.height)]
  return cell.empty? ? cell : get_empty_cell(level)
end

srand(Time.now.hash)

level = SimpleLayout.new.build(80, 40)

player = Player.new(get_empty_cell(level))
level.objects << player

10.times do 
  level.objects << Rat.new(get_empty_cell(level))
end

334.times do 
  level.objects << Plant.new(get_empty_cell(level))
end

3.times do 
  level.objects << Goblin.new(get_empty_cell(level))
end

#File.open("test.mrs",'w') do |file| 
#  file << Marshal.dump(level)
#end  

commands = CommandSet.new(level)
#File.open("test.mrs", 'r') do |file|
#  level = Marshal.load(file)
#end

if ARGV[0] == "--sdl" 
  require_all File.join(File.dirname(__FILE__), 'sdl')
  adapter = SdlAdapter.new
  event_handler = SdlEventHandler.new do |input|
    commands.handle(input)
    level.do_turn
    level.do_fov(player.x, player.y, 7)
    adapter.render(level)
  end
else
  adapter = GosuAdapter.new
  event_handler = GosuEventHandler.new do |input|
    commands.handle(input)
    level.do_turn
    level.get_fov(player, 7)
    adapter.render(level)
  end
end

level.get_fov(player, 7)
adapter.render(level)
adapter.startup(event_handler)
