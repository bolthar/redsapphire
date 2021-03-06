
require 'rubygems'
require 'sdl'

include SDL

class SdlAdapter
    
  def initialize
    TTF.init
    @screen = Screen.open(1440, 960, 0, HWSURFACE)
    @font = TTF.open(File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 36)
    @message_font = TTF.open(File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 20)
    @tiles = {}
    @map = Array.new(80*40, " ")
    File.open(File.join(File.dirname(__FILE__), 'tiles.txt')).lines.each do |line|
      values = line.strip.split("\t")
      @tiles[values[0]] = {
        :char  => values[1], 
        :color => [values[2].split(',')[0].to_i, values[2].split(',')[1].to_i, values[2].split(',')[2].to_i]
      }
    end
  end
  
  def startup(handler)
    SDL.init(SDL::INIT_EVERYTHING)
    handler.loop
  end
  
  def render(level)
    unless @map
      @map = []
      (level.width*level.height).times do
        @map << { :color => Gosu::Color::BLACK, :char => " " } 
      end
    end
    player = level.player
    center_x    = player.x
    center_y    = player.y
    center_x = 12 if center_x < 12
    center_y = 8 if center_y < 8
    center_x = level.width - 12 if center_x >= level.width - 12
    center_y = level.height - 8 if center_y >= level.height - 8
    (0...24).each do |x|
      (0...16).each do |y|
        cell = level[x - 12 + center_x, y - 8 + center_y]
        if player.field_of_view.include?(cell)
          @map[((y - 8 + center_y)*80)+ x - 12 + center_x] = get_char(cell)
          color = get_rgb(cell)
        else
          color = [120,120,120]
        end
        @screen.fill_rect(x * 14, y * 30 ,14 ,30, [0,0,0,0])
        @font.draw_blended_utf8(@screen, @map[((y - 8 + center_y)*80)+x - 12 + center_x], x * 14, y * 30,*color)
      end
    end
    draw_messages(level.messages.reverse.take(5))
    draw_enemies(level.enemies_in_sight)
    @screen.update_rect(0,0,1280,960)
  end

  def draw_messages(messages)
    @screen.fill_rect(0, 520 , 1280, 100,[0,0,0,0])
    (0...messages.length).each do |line|
      @message_font.draw_blended_utf8(@screen, messages[line], 0, (line * 20) + 520, *[255,255,255])
    end
  end

  def draw_enemies(enemies)
    @screen.fill_rect(600, 100, 200, 600,[0,0,0,0])
    (0...enemies.length).each do |index|
      @message_font.draw_blended_utf8(@screen, "#{get_char(enemies[index].owner)} #{enemies[index].hp}",600, (index * 20) + 100, *[255,255,255])
    end
  end

  def get_char(cell)
    return '.' unless cell.any?
    return @tiles[cell.to_a.last.symbol][:char]
  end

  def get_rgb(cell)
    return [0, 0, 0]       unless cell.visited?
    return [255, 255, 255] unless cell.any?    
    return [120, 120, 120] unless cell.on_sight?
    return @tiles[cell.to_a.last.symbol][:color]
  end

end
