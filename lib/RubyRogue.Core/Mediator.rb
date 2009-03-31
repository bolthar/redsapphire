# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  class Mediator

    def initialize(registry)
      @eventHandler = registry.eventHandler
      @adapter = registry.adapter
      @dumper = registry.dumper
      @architect = registry.architect
    end
    
    def start
      @level = @architect.build()
      @player = Player.new
      emptyCells = @level.getCells { |cell| cell.length == 0}
      playerCell = emptyCells[rand(emptyCells.length)]
      playerCell << @player
      eventResult = true
      while eventResult
        render()
        event = @eventHandler.getInput
        eventResult = handleEvent(event) if event
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
      playerCell = @level.getCells { |cell| cell.include? @player}[0]
      position = playerCell.position      
      @level.do_fov(position.x,position.y,6)     
      dumpedLevel = @adapter.convert(@level)      
      @dumper.render(dumpedLevel,9,15)
    end

    def move(direction)
      #get player position
      playerCell = @level.getCells { |cell| cell.include? @player}[0]
      position = playerCell.position
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
    
    def inventory()
      p @player.inventory
      return true
    end

     def gold()
      p @player.gold
      return true
    end


    def quit()
      return false
    end

  end
end
