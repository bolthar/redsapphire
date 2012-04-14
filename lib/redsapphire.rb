
require 'require_all'
require 'benchmark'

require_all File.join(File.dirname(__FILE__), 'core')
require_all File.join(File.dirname(__FILE__), 'gosu')

def move(player, destination)
  player.move(destination)
end

def get_empty_cell(level) 
  cell = level[rand(level.width), rand(level.height)]
  return cell.any? ? get_empty_cell(level) : cell
end

srand(Time.now.hash)

level = SimpleLayout.new.build(80, 40)

player = Player.new
get_empty_cell(level) << player

4.times do 
  get_empty_cell(level) << Rat.new
end

334.times do 
  get_empty_cell(level) << Plant.new
end

13.times do 
  get_empty_cell(level) << Goblin.new
end

30.times do
  get_empty_cell(level) << Potion.new
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
