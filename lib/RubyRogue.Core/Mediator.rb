# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  class Mediator

    def initialize
      registry = Needle::Registry.new do |reg|
        reg.register(:levelFiller) { LevelFiller.new }
        reg.register(:splitter) { Splitter.new }
        reg.register(:roomDigger) { RoomDigger.new }
        reg.register(:connector) { Connector.new }
      end
      @eventHandler = SDLeventHandler.new
      @adapter = SDLadapter.new
      @dumper = SDLdumper.new
      @architect = Architect.new(100,50,registry)
    end
    
    def start
      @dumper.startup(9,15,100,50)
      @level = @architect.build()
      @player = Player.new
      emptyCells = @level.getCells { |cell| cell.count == 0}
      playerCell = emptyCells[rand(emptyCells.count)]
      playerCell << @player
      eventResult = true
      while eventResult
        render()
        event = @eventHandler.getInput
        eventResult = handleEvent(event)
      end
    end

    def handleEvent(event)
      parameters = event[:parameters]
      if parameters
        self.send(event[:method],parameters)
      else
        self.send event[:method]
      end
    end

    def render
      playerCell = @level.getCells { |cell| cell[0] == @player}[0]
      position = @level.getPosition(playerCell)
      @level.do_fov(position.x,position.y,8)
      dumpedLevel = @adapter.convert(@level)
      @dumper.render(dumpedLevel,9,15)
    end

    def move(direction)
      #get player position
      playerCell = @level.getCells { |cell| cell[0] == @player}[0]
      position = @level.getPosition(playerCell)
      #get new position
      newPosition = position.move(direction)
      #try to put in new cell
      if @level.at(newPosition) << @player
         #if yes move player
         playerCell.delete(@player)
      end
      #if no do nothing
      return true
    end

    def quit()
      return false
    end

  end
end
