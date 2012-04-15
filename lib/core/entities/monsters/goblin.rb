
class Goblin < Monster

  attr_reader :hp #temp

  def initialize
    super
    @sleeping = true
    @hp = rand(8) + 4
  end

  def fill?
    return true
  end

  def hit(target)
    return 1
  end

  def name
    return "the goblin"
  end

  def turn_passed
    player = self.owner.level.player
    return unless player
    if !@field_of_view
      @field_of_view = self.owner.level.get_fov(self, 5)
    end
    @field_of_view = self.owner.level.get_fov(self, 5) unless @sleeping
    if(@field_of_view.include?(player.owner)) 
      @sleeping = false
      target = self.owner.level.get_shortest_path(self.owner, player.owner)[1]
      move(target) if target    
    end
  end

end
