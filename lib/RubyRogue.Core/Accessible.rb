# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  module Accessible

    def height
      return @height
    end

    def width
      return @width
    end

    def at(*args)
      if(args.length == 2)
        position = Position.new(args[0],args[1])
      else
        position = args[0]
      end
      raise "width is out of bounds (#{position.x})" unless position.x < width
      raise "height is out of bounds (#{position.y})" unless position.y < height
      return @cells[position.x][position.y]
    end
    
  end
end
