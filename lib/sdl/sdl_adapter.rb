
require 'rubygems'
require 'sdl'

include SDL

class SdlAdapter
    
  def initialize
    TTF.init
    @font = TTF.open(File.join(File.dirname(__FILE__), 'dejavu.ttf'), 12)
    @tiles = {}
    @tiles[Wall]       = {:char => '#', :color => [210, 105, 30]}
    @tiles[DoorClosed] = {:char => '+', :color => [210, 105, 30]}
    @tiles[DoorOpen]   = {:char => '`', :color => [210, 105, 30]}
    @tiles[DoorSecret] = {:char => '#', :color => [210, 0, 30]}
    @tiles[Player]     = {:char => '@', :color => [255, 255, 255]}
    @tiles[Item]       = {:char => '?', :color => [99, 184, 255]}
    @tiles[Gold]       = {:char => '*', :color => [240, 230, 140]}
    @tiles[GiantBat]   = {:char => 'b', :color => [255, 255, 255]}
  end
  
  def startup
    SDL.init(SDL::INIT_EVERYTHING)
    @screen = Screen.open(640, 480, 0, HWSURFACE)
  end
  
  def render(level)
    player_cell = level.select { |l| l.any? { |el| el.kind_of? Player }}.first
    center_x    = player_cell.position.x
    center_y    = player_cell.position.y
    center_x = 15 if center_x < 15
    center_y = 10 if center_y < 10
    center_x = level.width - 15 if center_x >= level.width - 15
    center_y = level.height - 10 if center_y >= level.height - 10
    (0...30).each do |x|
      (0...20).each do |y|
        cell = level[x - 15 + center_x, y - 10 + center_y]
        @screen.fill_rect(x * 8, y * 14 ,8 ,14,[0,0,0,0])
        @font.draw_blended_utf8(@screen, get_char(cell), x * 8, y * 14,*get_rgb(cell))
      end
    end
#    draw_gold(level.player.gold)
#    draw_items(level.player.inventory)
    @screen.update_rect(0,0,640,480)
  end

  def get_char(cell)
    return '.' if cell.empty?
    return @tiles[cell.first.symbol][:char]
  end

  def get_rgb(cell)
    return [0, 0, 0]       unless cell.visited?
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