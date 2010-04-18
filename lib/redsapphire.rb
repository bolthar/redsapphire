
require 'headers.rb'

include LevelBuilder
include LevelBuilder::Workers
include Core
include Core::Elements

class Registry

  def initialize
    @x = 50
    @y = 25
    @w = 9
    @h = 15
  end

  def levelFiller
    return LevelFiller.new
  end

  def splitter
    return Splitter.new
  end

  def roomDigger
    return RoomDigger.new
  end

  def connector
    return Connector.new
  end

  def architect
    return Architect.new(@x, @y, self)
  end

  def eventHandler
    return SdlEventHandler.new
  end

  def adapter
    return SdlAdapter.new()
  end

  def itemPopulator
    return ItemPopulator.new
  end

end

registry = Registry.new
srand(Time.now.hash)
mediator = Mediator.new(registry)
mediator.start

