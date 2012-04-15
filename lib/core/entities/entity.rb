
class Entity

  def owner
    return @owner
  end

  def owner=(container)
    @owner.objects.delete(self) if @owner
    @owner = container
  end

  def destroy
    @owner.objects.delete(self)
    @owner = nil
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

  def symbol
    return self.class.to_s
  end

end
