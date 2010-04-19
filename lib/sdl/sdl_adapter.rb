
require 'rubygems'
require 'sdl'

include SDL

class SdlAdapter
    
  def initialize
    TTF.init
    @font = TTF.open(File.join(File.dirname(__FILE__), 'dejavu.ttf'), 12)
    @tiles = {}
    File.open(File.join(File.dirname(__FILE__), 'tiles.txt')).lines.each do |line|
      values = line.strip.split("\t")
      p values
      @tiles[values[0]] = {:char => values[1], 
                           :color =>
                             [values[2].split(',')[0], values[2].split(',')[1], values[2].split(',')[2]]}
    end
  end
  
  def startup
    SDL.init(SDL::INIT_EVERYTHING)
    @screen = Screen.open(640, 480, 0, HWSURFACE)
  end
  
  def render(level)
#    player_cell = level.select { |l| l.any? { |el| el.kind_of? Player }}.first
#    center_x    = player_cell.position.x
#    center_y    = player_cell.position.y
#    center_x = 15 if center_x < 15
#    center_y = 10 if center_y < 10
#    center_x = level.width - 15 if center_x >= level.width - 15
#    center_y = level.height - 10 if center_y >= level.height - 10
    (0...level.width).each do |x|
      (0...level.height).each do |y|
#        cell = level[x - 15 + center_x, y - 10 + center_y]
        cell = level[x, y]
        @screen.fill_rect(x * 8, y * 14 ,8 ,14,[0,0,0,0])
        @font.draw_blended_utf8(@screen, get_char(cell), x * 8, y * 14,*get_rgb(cell))
      end
    end
    @screen.update_rect(0,0,640,480)
  end

  def get_char(cell)
    return '.' if cell.empty?
    return @tiles[cell.first.symbol][:char]
  end

  def get_rgb(cell)
#    return [0, 0, 0]       unless cell.visited?
    return [255, 255, 255] if cell.empty?
    return [120, 120, 120] unless cell.on_sight?
    return @tiles[cell.first.symbol][:color]
  end

end