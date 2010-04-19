
class Entity

  attr_accessor :owner
  
  def initialize(owner)
    @owner = owner
  end

  def symbol
    return self.class.to_s
  end

end