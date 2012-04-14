
class Player < Entity

  attr_reader :hp

  def initialize
    super
    @actions = {}
    @actions[Monster] = Attack.new
    @healing_counter = 0
    @hp = 10
    @max_hp = 10
    @potions = []
  end

  def quaff
    potion = @potions.pop
    if potion
      heal = rand(3) + 2
      message "You drink a potion. You gain #{heal} hp!"
      @hp = @hp + heal
      @hp = @max_hp if @hp > @max_hp
      potion.destroy
    else
      message "You have no potions left."
    end
  end

  def turn_passed
    @healing_counter += 1
    if @healing_counter == 10
      @hp += 1 unless @hp == @max_hp
      @healing_counter = 0
    end
  end

  def get_damage(hit)
    @hp -= hit
    if @hp <= 0
      message "You are dead!"
    end
  end

  def fill?
    return true
  end

  def can_see_through?
    return true
  end

  def name
    return "you"
  end

  def hit(target)
    return rand(3)
  end

  def move(destination)
    unless destination.blocked? && @hp > 0
      destination << self
      destination.each do |entity|
        self.interact_with(entity)
      end
    else
      self.interact_with(destination.first)
    end
  end

  def pick_up
    potion = self.owner.select { |x| x.kind_of? Potion }.first
    if potion
      potion.owner = self
      @potions << potion
      message "You get a potion!"
    end
  end

end
