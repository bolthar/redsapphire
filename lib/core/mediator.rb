# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  class Mediator

    def initialize(registry)
      @event_handler = registry.eventHandler
      @adapter       = registry.adapter
      @architect     = registry.architect
    end
    
    def start
      @adapter.startup
      @level = @architect.build()
      @player = Player.new
      @monsters = [GiantBat.new, GiantBat.new, GiantBat.new]
      @monsters.each do |m|
        m.when_dead do
          @monsters.delete(m)
          @level.select { |cell| cell.include?(m)}.first.delete(m)
        end
      end
      [@player, *@monsters].each do |entity|
        emptyCells = @level.select { |cell| cell.length == 0}
        playerCell = emptyCells[rand(emptyCells.length)]
        playerCell << entity
        p playerCell.position
      end
      event_result = true
      while event_result
        render()
        event = @event_handler.get_input
        event_result = handleEvent(event) if event
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
      playerCell = @level.select { |cell| cell.include? @player}[0]
      position = playerCell.position      
      @level.do_fov(position.x,position.y,6)     
      @adapter.render(@level) 
    end

    def move(direction)
      #get player position
      playerCell = @level.select { |cell| cell.include? @player}[0]
      position = playerCell.position
      #get new position
      newPosition = position.move(direction)
      #try to put in new cell
      if @level[newPosition.x, newPosition.y] << @player
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
