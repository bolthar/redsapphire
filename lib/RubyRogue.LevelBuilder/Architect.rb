
include Core

module LevelBuilder

  class Architect

    @numberOfFeatures = 10
    
    def initialize(width, height, registry)
      @level = Level.new(width,height)
      @levelFiller = registry.levelFiller
      @splitter = registry.splitter
      @roomDigger = registry.roomDigger
    end

    def build
      @levelFiller.fillLevel!(@level)
      zones = @splitter.split(@level)
      zones.each do |column|
        column.each do |singleZone|
          while(!singleZone.center)
            x = rand(singleZone.width)
            y = rand(singleZone.height)
            width = rand(singleZone.width)
            height = rand(singleZone.height)
            @roomDigger.buildFeature!(singleZone) if x + width <= singleZone.width and y + height <= singleZone.height
            end
          end          
        end
      end
      
  end

end
