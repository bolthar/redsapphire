
class Entity

  attr_reader :owner
  
  def initialize(owner)
    @owner = owner
    @owner.invalidate
  end

  def x
    return @owner.x
  end

  def y
    return @owner.y
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