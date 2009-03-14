
include Core

module LevelBuilder

  class Architect

    @numberOfFeatures = 10
    
    def initialize(width, height, registry)
      @mason = registry.mason
      @digger = registry.digger
      @level = Level.new(width,height)
    end

    def build
      @mason.fillLevel(@level)
      @digger.digFeatures(@level)
      return @level
    end



  end

end
