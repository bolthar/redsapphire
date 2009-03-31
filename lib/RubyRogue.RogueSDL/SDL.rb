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

class Colors


  @colors = {}

  def Colors.White 
    @colors[:white] = Color.new(1,1,1) if !@colors[:white]
    return @colors[:white]
  end
  
  def Colors.LightBrown 
     @colors[:lightBrown] = Color.new(0.7,0.1,0) if !@colors[:lightBrown]
     return @colors[:lightBrown]
  end
  
  def Colors.DarkBrown 
     @colors[:darkBrown] = Color.new(0.5,0.1,0) if !@colors[:darkBrown]
     return @colors[:darkBrown]
  end
  
  def Colors.Black 
    @colors[:black] = Color.new(0,0,0) if !@colors[:black]
    return @colors[:black]
  end

  def Colors.Gray
    @colors[:grey] = Color.new(0.2,0.2,0.2) if !@colors[:grey]
    return @colors[:grey]
  end

  def Colors.LightBlue
    @colors[:lightBlue] = Color.new(0.3,0.3,1) if !@colors[:lightBlue]
    return @colors[:lightBlue]
  end


  
end

class SpriteCache

  def initialize(w,h)
    @fontPalette = Surface.loadBMP('FontPalette.bmp')

    @x = w
    @y = h

    @palettePositions = {}
    @palettePositions[:emptyCell] = {:x => 10, :y => 2, :defaultColor => Colors.White}
    @palettePositions[Wall] = {:x => 22, :y => 2, :defaultColor => Colors.DarkBrown}
    @palettePositions[DoorClosed] = {:x => 11, :y => 2, :defaultColor => Colors.LightBrown}
    @palettePositions[DoorOpen] = {:x => 19, :y => 2, :defaultColor => Colors.LightBrown}
    @palettePositions[DoorSecret] = {:x => 22, :y => 2, :defaultColor => Colors.LightBrown}
    @palettePositions[:invisible] = {:x => 22, :y => 2, :defaultColor => Colors.Black}
    @palettePositions[Player] = {:x => 23, :y => 2, :defaultColor => Colors.White}
    @palettePositions[Item] = {:x => 7, :y => 2, :defaultColor => Colors.LightBlue}

    @cache = {}    
    @palettePositions.each_pair do |key,value|      
      @cache[key] = {}
      @cache[key][value[:defaultColor]] = getCharSurface(value[:x],value[:y],value[:defaultColor])
    end
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

  def getSprite(type,color)
    if color
      if !@cache[type][color]
        palettePosition, = @palettePositions[type]
        @cache[type][color] = getCharSurface(palettePosition[:x],palettePosition[:y],color)
      end
      return @cache[type][color]
    else
      return @cache[type][@palettePositions[type][:defaultColor]]
    end
  end
  
  def getDefaultColor(type)    
    return @palettePositions[type][:defaultColor]
  end
end
class SDLadapter
  
  def initialize(w,h,colunms)
    
    @spriteCache = SpriteCache.new(w,h)

    @drawingMap = []
    for x in 0...colunms
      @drawingMap[x] = []
    end
    
  end
    
  
  def convert(level)
    dumpedLevel = []
    for x in 0...level.width
      dumpedLevel[x] = []
      for y in 0...level.height
       assignDrawingMap(level.at(x,y))
       if @drawingMap[x][y]
        dumpedLevel[x][y] = @spriteCache.getSprite(@drawingMap[x][y][:type],@drawingMap[x][y][:color])
       end
      end
    end
    return dumpedLevel
  end

  def assignDrawingMap(cell)
    if @drawingMap[cell.position.x][cell.position.y]
        @drawingMap[cell.position.x][cell.position.y][:color] = Colors.Gray
      end
    if cell.onSight?
      #assign level symbol
      if cell.length == 0
        @drawingMap[cell.position.x][cell.position.y] = {:type => :emptyCell, :color => @spriteCache.getDefaultColor(:emptyCell)}
      else
        if cell.length == 2
           @drawingMap[cell.position.x][cell.position.y] = {:type => cell[1].symbol, :color => @spriteCache.getDefaultColor(cell[1].symbol)}
        else
           @drawingMap[cell.position.x][cell.position.y] = {:type => cell[0].symbol, :color => @spriteCache.getDefaultColor(cell[0].symbol)}
        end
      end      
    end
  end
end

class SDLdumper

  def startup(cellWidth,cellHeight,cellX,cellY)
    SDL.init(SDL::INIT_VIDEO)
    SDL::Screen.open(cellWidth*cellX,cellHeight*cellY,0,SDL::HWSURFACE)
    @screen = Screen.get   
  end

  def render(dumpedLevel,cellWidth,cellHeight)
    for x in 0...dumpedLevel.length
      for y in 0...dumpedLevel[x].length
        if dumpedLevel[x][y] 
          Surface.blit(dumpedLevel[x][y],0,0,cellWidth,cellHeight,@screen,x*cellWidth,y*cellHeight)
        end
      end
    end
    @screen.update_rect(0,0,0,0)
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