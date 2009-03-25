# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'rubygems'
require 'sdl'

include SDL
include Core



module SDLWrapper
class Color

  def initialize(redFactor,greenFactor,blueFactor)
    @red = redFactor
    @green = greenFactor
    @blue = blueFactor
  end

  def red
     return @red
  end

  def green
    return @green
  end

  def blue
    return @blue
  end

  def create(baseColor)
    newColor = []
    newColor[0] = baseColor[0] * red
    newColor[1] = baseColor[1] * green
    newColor[2] = baseColor[2] * blue
    return newColor
  end

end
class SDLadapter


  
  def initialize
    @fontPalette = Surface.loadBMP('FontPalette.bmp')
    
    @x = 9
    @y = 15
    
    @surfaces = {}
    @surfaces[:emptyCell] = getCharSurface(10,2, Color.new(1,1,1))
    @surfaces[Wall] = getCharSurface(22,2,Color.new(0.4,0.1,0))
    @surfaces[DoorClosed] = getCharSurface(11,2,Color.new(0.5,0.1,0))
    @surfaces[DoorOpen] = getCharSurface(19,2,Color.new(0.5,0.1,0))
    @surfaces[DoorSecret] = getCharSurface(22,2,Color.new(0.7,0.1,0))
    @surfaces[:invisible] = getCharSurface(22,2,Color.new(0,0,0))
    @surfaces[Player] = getCharSurface(23,2,Color.new(1,1,1))
  end
  
  def getCharSurface(x,y,paintColor)
    charSurface = Surface.new(SDL::HWSURFACE,@x,@y,@fontPalette.format)   
    Surface.blit(@fontPalette,@x*x,@y*y,@x,@y,charSurface,0,0)
    for xPixel in 0...@x
      for yPixel in 0...@y
       color = charSurface.format.getRGB(charSurface[xPixel,yPixel])
       newColor = paintColor.create(color)
       charSurface[xPixel,yPixel] = newColor
      end
    end
    return charSurface
  end
  
  def convert(level)
    result = []    
    for x in 0...level.width
      result[x] = []
      for y in 0...level.height
       if level.at(x,y).onSight?
        if level.at(x,y).count == 0
          result[x][y] = @surfaces[:emptyCell]
        else
          if level.at(x,y).count == 2
             result[x][y] = @surfaces[level.at(x,y)[1].symbol]
          else
             result[x][y] = @surfaces[level.at(x,y)[0].symbol]
          end          
        end
       else
         result[x][y] = @surfaces[:invisible]
      end
    end    
  end
  return result
end
end

class SDLdumper

  def startup(cellWidth,cellHeight,cellX,cellY)
    SDL.init(SDL::INIT_VIDEO)
    SDL::Screen.open(cellWidth*cellX,cellHeight*cellY,0,SDL::HWSURFACE)
  end

  def render(dumpedLevel,cellWidth,cellHeight)
    screen = Screen.get    
    for x in 0...dumpedLevel.count
      for y in 0...dumpedLevel[x].count       
        Surface.blit(dumpedLevel[x][y],0,0,cellWidth,cellHeight,screen,x*cellWidth,y*cellHeight)
      end
    end
    screen.update_rect(0,0,0,0)
  end
end

class SDLeventHandler

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
  end


  def getInput
    event = nil
    while !event
      event = Event.wait
      if event.kind_of? Event::KeyDown
        return parseEvent(event)
      end
      event = nil
    end
  end

  private
  def parseEvent(event)
    result = @keyMap[event.sym]
    return result
  end

end
end