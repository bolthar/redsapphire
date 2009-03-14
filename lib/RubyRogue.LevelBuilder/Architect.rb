
include Core

module LevelBuilder

  class Architect

    @numberOfFeatures = 10
    
    def initialize(width, height, registry)
      @level = Level.new(width,height)
      @levelFiller = registry.levelFiller
      @splitter = registry.splitter
      @roomDigger = registry.roomDigger
      @connector = registry.connector
    end

    def build
      @levelFiller.fillLevel!(@level)
      zones = @splitter.split(@level,5,5)
      zones.each do |column|
        column.each do |singleZone|
          while(!singleZone.center)
            x = rand(singleZone.width)
            y = rand(singleZone.height)
            width = rand(singleZone.width - x)
            height = rand(singleZone.height - y)
            @roomDigger.buildFeature!(singleZone,x,y,width,height)
          end
        end          
      end
      zones[0][0].connect #connect first zone
      p "start"
      while(!allZonesConnected?(zones))
        "connect"
        connectRandomZone(zones)
      end
    end

    private
    def allZonesConnected?(zones)
      
      for x in 0...zones.length        
        for y in 0...zones[x].length         
          return false if !zones[x][y].connected?
        end
      end
      "exit method"
      return true
    end

    def connectRandomZone(zones)
      x = rand(zones.length)
      y = rand(zones[x].length)
      connected = false      
      while(!connected)
        while(!zones[x][y].connected?)         
         x = rand(zones.length)
         y = rand(zones[x].length)
         
        end
        direction = Direction.randomCardinal       
        xTarget = x + direction.x
        yTarget = y + direction.y
        if(xTarget > -1 && yTarget > -1)
          if(!zones[xTarget][yTarget].connected?)
             p "source: #{x},#{y}"
             p "target: #{xTarget},#{yTarget}"
             @connector.connect!(zones[x][y],zones[xTarget][yTarget],direction)
             connected = true
          end
        end
      end
    end

  end
end
