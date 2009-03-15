
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
            width = rand(singleZone.width - 1)
            height = rand(singleZone.height - 1)
            x = rand(singleZone.width - width - 1) + 1
            y = rand(singleZone.height - height- 1) + 1
            @roomDigger.buildFeature!(singleZone,x,y,width,height)
          end
        end          
      end
      zones[0][0].connect #connect first zone      
      while(!allZonesConnected?(zones))       
        connectRandomZone(zones)
      end
      return @level
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
        x = rand(zones.length)
        y = rand(zones[x].length)
        if(zones[x][y].connected?)
         direction = Direction.randomCardinal
         xTarget = x + direction.x
         yTarget = y + direction.y
         if(xTarget > -1 && yTarget > -1 && xTarget < zones.length && yTarget < zones[x].length)           
            if(!zones[xTarget][yTarget].connected?)               
               @connector.connect!(zones[x][y],zones[xTarget][yTarget],direction)
               connected = true
            end
         end
        end
      end
    end

  end
end
