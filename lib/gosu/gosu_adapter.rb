
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
    @font = Gosu::Font.new(self, File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 22)
    @message_font = Gosu::Font.new(self, File.join(File.dirname(__FILE__), 'proggytiny.ttf'), 20)
    @tiles = {}
    @gray = Gosu::Color.argb(Integer("0xff787878"))
    @center_x = -1
    @center_y = -1
    File.open(File.join(File.dirname(__FILE__), 'tiles.txt')).lines.each do |line|
      values = line.strip.split("\t")
      @tiles[values[0]] = {
        :char  => values[1], 
        :color => [values[2].split(',')[0].to_i, values[2].split(',')[1].to_i, values[2].split(',')[2].to_i]
      }
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
    unless @map
      @map = []
      (@level.width*@level.height).times do
        @map << { :color => Gosu::Color::BLACK, :char => " " } 
      end
    end
    prepare_for_draw
  end

  VISIBLE_AREA_RADIUS_X = 20
  VISIBLE_AREA_RADIUS_Y = 12

  def prepare_for_draw
    player = @level.player
    @center_x    = player.x
    @center_y    = player.y
    @center_x = VISIBLE_AREA_RADIUS_X if @center_x < VISIBLE_AREA_RADIUS_X 
    @center_y = VISIBLE_AREA_RADIUS_Y if @center_y < VISIBLE_AREA_RADIUS_Y
    @center_x = @level.width - VISIBLE_AREA_RADIUS_X if @center_x >= @level.width - VISIBLE_AREA_RADIUS_X
    @center_y = @level.height - VISIBLE_AREA_RADIUS_Y if @center_y >= @level.height - VISIBLE_AREA_RADIUS_Y
    (0...VISIBLE_AREA_RADIUS_X*2).each do |x|
      (0...VISIBLE_AREA_RADIUS_Y*2).each do |y|
        cell = @level[x - VISIBLE_AREA_RADIUS_X + @center_x, y - VISIBLE_AREA_RADIUS_Y + @center_y]
        map_cell = @map[((y - VISIBLE_AREA_RADIUS_Y + @center_y)*@level.width)+ x - VISIBLE_AREA_RADIUS_X + @center_x] 
        if player.field_of_view.include?(cell)
          map_cell[:char]  = get_char(cell)
          map_cell[:color] = get_rgb(cell)
        else
          map_cell[:color] = @gray 
        end
      end
    end
  end

  def draw
    (0...VISIBLE_AREA_RADIUS_X*2).each do |x|
      (0...VISIBLE_AREA_RADIUS_Y*2).each do |y|
      	map_cell = @map[((y - VISIBLE_AREA_RADIUS_Y + @center_y)*@level.width)+ x - VISIBLE_AREA_RADIUS_X + @center_x] 
        @font.draw(map_cell[:char], x * 14, y * 22, 1, 1, 1, map_cell[:color])
      end
    end
    draw_messages(@level.messages.reverse.take(5))
    draw_enemies(@level.enemies_in_sight)
  end

  def draw_messages(messages)
    (0...messages.length).each do |line|
      @message_font.draw(messages[line], 0, (line * 20) + 600, 1, 1, 1, Gosu::Color::WHITE)
    end
  end

  def draw_enemies(enemies)
    (0...enemies.length).each do |index|
      @message_font.draw("#{get_char(enemies[index].owner)} #{enemies[index].hp}",600, (index * 20) + 100, 1, 1, 1, Gosu::Color::WHITE)
    end
  end

  def get_char(cell)
    return '.' unless cell.any?
    return @tiles[cell.to_a.last.symbol][:char]
  end

  def get_rgb(cell)
    return Gosu::Color::BLACK unless cell.visited?
    return Gosu::Color::WHITE unless cell.any?    
    return @gray unless cell.on_sight?
    return color_from_rgb(*@tiles[cell.to_a.last.symbol][:color])
  end

end
