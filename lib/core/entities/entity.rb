
class Entity

  attr_reader :owner
  
  def initialize(owner)
    @owner = owner
    @owner.invalidate
  end

  def destroy
    old_owner = @owner
    @owner = nil
    old_owner.invalidate
  end

  def interact_with(target)
    action = get_action(target.class)
    action.execute(self, target) if action
  end

  def get_action(klass)
    return @actions[klass] if @actions[klass]
    return nil unless klass.superclass
    return get_action(klass.superclass)
  end

  def message(message)
    @owner.add_message(message)
  end

  def x
    return @owner.x
  end

  def y
    return @owner.y
  end

  def turn_passed
    
  end

  def field_of_view
    return @field_of_view
  end

  def field_of_view=(cells)
    cells.each { |x| x.light }
    @field_of_view = cells
  end

  def owner=(new_owner)
    old_owner = @owner
    @owner    = new_owner
    old_owner.invalidate
    @owner.invalidate
  end

  def symbol
    return self.class.to_s
  end

end
