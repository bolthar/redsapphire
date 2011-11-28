
require 'rubygems'
require 'gosu'

include Gosu

class GosuAdapter < Gosu::Window
    
  def format_to_hex(int)
    return "%02x" % int
  end

  def color_from_rgb(r,g,b)
    return Gosu::Color.argb(Integer("0xff#{format_to_hex(r)}#{format_to_hex(g)}#{format_to_hex(b)}"))
  end

  def initialize
    super 1024, 768, false
    @font = Gosu::Font.new(self, File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 24)
    @message_font = Gosu::Font.new(self, File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 20)
    @tiles = {}
    @gray = Gosu::Color.argb(Integer("0xff787878"))
    @map = Array.new(80*40, " ")
    File.open(File.join(File.dirname(__FILE__), 'tiles.txt')).lines.each do |line|
      values = line.strip.split("\t")
      @tiles[values[0]] = {:char => values[1], 
                           :color =>
                             [values[2].split(',')[0].to_i, values[2].split(',')[1].to_i, values[2].split(',')[2].to_i]}
    end
  end
  
  def startup(helper) 
    @command_helper = helper
    self.show
  end
  
  def button_down(id)
    @command_helper.get_input(id)
  end
  
  def render(level)
    @level = level
  end

  def draw
    center_x    = @level.player.x
    center_y    = @level.player.y
    center_x = 20 if center_x < 20 
    center_y = 12 if center_y < 12
    center_x = @level.width - 12 if center_x >= @level.width - 12
    center_y = @level.height - 8 if center_y >= @level.height - 8
    (0...40).each do |x|
      (0...24).each do |y|
        cell = @level[x - 20 + center_x, y - 12 + center_y]
        if cell.on_sight?
          @map[((y - 12 + center_y)*80)+ x - 20 + center_x] = get_char(cell)
          color = get_rgb(cell)
        else
          color = @gray 
        end
        @font.draw(@map[((y - 12 + center_y)*80)+x - 20 + center_x], x * 14, y * 22, 1, 1, 1, color)
      end
    end
    draw_messages(@level.messages.reverse.take(5))
    draw_enemies(@level.enemies_in_sight)
  end

  def draw_messages(messages)
    (0...messages.length).each do |line|
      @message_font.draw(messages[line], 0, (line * 20) + 520, 1, 1, 1, Gosu::Color::WHITE)
    end
  end

  def draw_enemies(enemies)
    (0...enemies.length).each do |index|
      @message_font.draw("#{get_char(enemies[index].owner)} #{enemies[index].hp}",600, (index * 20) + 100, 1, 1, 1, Gosu::Color::WHITE)
    end
  end

  def get_char(cell)
    return '.' if cell.empty?
    return @tiles[cell.first.symbol][:char]
  end

  def get_rgb(cell)
    return Gosu::Color::BLACK unless cell.visited?
    return @gray unless cell.on_sight?
    return Gosu::Color::WHITE if cell.empty?    
    return color_from_rgb(*@tiles[cell.first.symbol][:color])
  end

end
