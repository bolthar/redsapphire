
require 'rubygems'
require 'sdl'

include SDL

class SdlAdapter
    
  def initialize
    TTF.init
    @font = TTF.open(File.join(File.dirname(__FILE__), 'dejavu.ttf'), 12)
    @message_font = TTF.open(File.join(File.dirname(__FILE__), 'dejavu.ttf'), 10)
    @tiles = {}
    @map = Array.new(80*40, " ")
    File.open(File.join(File.dirname(__FILE__), 'tiles.txt')).lines.each do |line|
      values = line.strip.split("\t")
      @tiles[values[0]] = {:char => values[1], 
                           :color =>
                             [values[2].split(',')[0].to_i, values[2].split(',')[1].to_i, values[2].split(',')[2].to_i]}
    end
  end
  
  def startup
    SDL.init(SDL::INIT_EVERYTHING)
    @screen = Screen.open(720, 480, 0, HWSURFACE)
  end
  
  def render(level)
    center_x    = level.player.x
    center_y    = level.player.y
    center_x = 12 if center_x < 12
    center_y = 8 if center_y < 8
    center_x = level.width - 12 if center_x >= level.width - 12
    center_y = level.height - 8 if center_y >= level.height - 8
    (0...24).each do |x|
      (0...16).each do |y|
        cell = level[x - 12 + center_x, y - 8 + center_y]
        if cell.on_sight?
          @map[((y - 8 + center_y)*80)+ x - 12 + center_x] = get_char(cell)
          color = get_rgb(cell)
        else
          color  = [120,120,120]
        end
        @screen.fill_rect(x * 7, y * 15 ,7 ,15, [0,0,0,0])
        @font.draw_blended_utf8(@screen, @map[((y - 8 + center_y)*80)+x - 12 + center_x], x * 7, y * 15,*color)
      end
    end
    draw_messages(level.messages.reverse.take(5))
    draw_enemies(level.enemies_in_sight)
    @screen.update_rect(0,0,640,480)
  end

  def draw_messages(messages)
    @screen.fill_rect(0, 260 , 640, 50,[0,0,0,0])
    (0...messages.length).each do |line|
      @message_font.draw_blended_utf8(@screen, messages[line], 0, (line * 10) + 260, *[255,255,255])
    end
  end

  def draw_enemies(enemies)
    @screen.fill_rect(300, 50, 100, 300,[0,0,0,0])
    (0...enemies.length).each do |index|
      @message_font.draw_blended_utf8(@screen, "#{get_char(enemies[index].owner)} #{enemies[index].hp}",300, (index * 10) + 50, *[255,255,255])
    end
  end

  def get_char(cell)
    return '.' if cell.empty?
    return @tiles[cell.first.symbol][:char]
  end

  def get_rgb(cell)
    return [0, 0, 0]       unless cell.visited?
    return [120, 120, 120] unless cell.on_sight?
    return [255, 255, 255] if cell.empty?    
    return @tiles[cell.first.symbol][:color]
  end

end