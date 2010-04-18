
require 'rubygems'
require 'sdl'

include SDL

class SdlEventHandler

  def initialize()
    @keyMap = {}
    @keyMap[SDL::Key::KP8] = {:method => :move, :parameters => Direction.Up}
    @keyMap[SDL::Key::KP9] = {:method => :move, :parameters => Direction.UpRight}
    @keyMap[SDL::Key::KP6] = {:method => :move, :parameters => Direction.Right}
    @keyMap[SDL::Key::KP3] = {:method => :move, :parameters => Direction.DownRight}
    @keyMap[SDL::Key::KP2] = {:method => :move, :parameters => Direction.Down}
    @keyMap[SDL::Key::KP1] = {:method => :move, :parameters => Direction.DownLeft}
    @keyMap[SDL::Key::KP4] = {:method => :move, :parameters => Direction.Left}
    @keyMap[SDL::Key::KP7] = {:method => :move, :parameters => Direction.UpLeft}
    @keyMap[SDL::Key::Q] = {:method => :quit}
    @keyMap[SDL::Key::I] = {:method => :inventory}
    @keyMap[SDL::Key::G] = {:method => :gold}
  end

  def get_input
    event = nil
    while !event
      event = Event.wait
      if event.kind_of? Event::KeyDown
        return parse_event(event)
      end
      event = nil
    end
  end

  private
  def parse_event(event)
    result = @keyMap[event.sym]
    return result
  end

end

class SdlAdapter
    
  def initialize
    TTF.init
    @font = TTF.open(File.join(File.dirname(__FILE__), 'dejavu.ttf'), 12)
    @tiles = {}
    @tiles[Wall]       = {:char => '#', :color => [210, 105, 30]}
    @tiles[DoorClosed] = {:char => '+', :color => [210, 105, 30]}
    @tiles[DoorOpen]   = {:char => '`', :color => [210, 105, 30]}
    @tiles[DoorSecret] = {:char => '#', :color => [210, 105, 30]}
    @tiles[Player]     = {:char => '@', :color => [255, 255, 255]}
    @tiles[Item]       = {:char => '?', :color => [99, 184, 255]}
    @tiles[Gold]       = {:char => '*', :color => [240, 230, 140]}
  end
  
  def startup
    SDL.init(SDL::INIT_EVERYTHING)
    @screen = Screen.open(640, 480, 0, HWSURFACE)
  end
  
  def render(level)
    (0...level.width).each do |x|
      (0...level.height).each do |y|
        cell = level.at(x,y)
        @screen.fill_rect(x * 8, y * 14 ,8 ,14,[0,0,0,0])
        @font.draw_blended_utf8(@screen, get_char(cell), x * 8, y * 14,*get_rgb(cell))
      end
    end
    draw_gold(level.player.gold)
    draw_items(level.player.inventory)
    @screen.update_rect(0,0,640,480)
  end

  def get_char(cell)
    return '.' if cell.empty?
    return @tiles[cell.first.symbol][:char]
  end

  def get_rgb(cell)
    return [255, 255, 255] if cell.empty?
    return [120, 120, 120] unless cell.onSight?
    return @tiles[cell.first.symbol][:color]
  end

  def draw_gold(gold)
    @screen.fill_rect(450, 0 ,8 * 10 ,14,[0,0,0,0])
    @font.draw_blended_utf8(@screen, "Gold #{gold}", 450, 0, *[200, 50, 10])
  end

  def draw_items(inventory)
    @screen.fill_rect(450, 28 ,8 * 12 ,14 * 10,[0,0,0,0])
    @font.draw_blended_utf8(@screen, "ITEMS" , 450, 28 , *[0, 200, 100])
    inventory.each do |item|
      @font.draw_blended_utf8(@screen, item.name , 450, (inventory.index(item) * 14) + 42 , *[0, 200, 100])
    end
  end

end

#surface1 = ttf.draw_blended_utf8("sadssssssssssssssdasdadasdada", 255, 0, 0)
#surface2 = ttf.render_blended_utf8("sfgsertgsvczxfgsegfdcvsdrfgev", 0, 255, 0)
#surface3 = ttf.render_blended_utf8("ertergzfvdsf5tegxvdfrgevfdbad", 0, 0, 255)
#
#Screen.blit(surface1, 0, 0, 0, 0, Screen.get, 0, 0)
#Screen.blit(surface2, 0, 0, 0, 0, Screen.get, 0, 10)
#Screen.blit(surface3, 0, 0, 0, 0, Screen.get, 0, 20)
#Screen.get.update_rect(0,0,0,0)

#class Tile
#
#  @@chars = ('a'..'z').to_a
#
#  def initialize
#    @elements = Array.new(25, 0)
#  end
#
#  def get_tile
#    return @@chars[rand(26)]
#  end
#
#  def notify
#    @elements.each do |el|
#      el += 1
#      b += 1 if el % 10 == 0
#      c += 1 if el % 20 == 0
#      d += 1 if el % 10 == 0 && el % 30 == 0
#    end
#  end
#
#end
#cache = []
#81.times do
#  cache << Array.new(25, Tile.new)
#end
#
##big_array = Array.new(1000, "test")
#
#results = []
#100.times do
#  time = Time.now
##  big_array.each do |test|
##    test.split("t").join()
##  end
#  cache.each do |array|
#    array.each do |element|
#      element.notify
#    end
#  end
#  screen = Screen.get
#  (0..20).each do |line|
#    (0..35).each do |column|
#      # if cache[column][line] != char
#        screen.fill_rect(column * 8, line * 14 ,8 ,14,[0,0,0,0])
#        ttf.draw_blended_utf8(screen, cache[column][line].get_tile ,column * 8, line*14, rand(255), rand(255), rand(255))
##        cache[column][line] = char
##      end
#    end
#  end
#  screen.update_rect(0,0,640,480)
#  results << Time.now - time
#end
#
#p results.inject(0.0) { |sum, value| sum += value } / 100.0
#
#
# def convert(level)
#   (0...level.width).each do |x|
#     (0...level.height).each do |y|
#
#       ttf.draw_blended_utf8(screen, cache[column][line].get_tile ,column * 8, line*14, rand(255), rand(255), rand(255))
#     end
#   end
##    dumpedLevel = []
##    for x in 0...level.width
##      dumpedLevel[x] = []
##      for y in 0...level.height
##       assignDrawingMap(level.at(x,y))
##       if @drawingMap[x][y]
##        dumpedLevel[x][y] = @spriteCache.getSprite(@drawingMap[x][y][:type],@drawingMap[x][y][:color])
##       end
##      end
##    end
##    return dumpedLevel
#  end