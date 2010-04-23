
class OutOfBounds < Cell

  def initialize
    
  end
  
  def on_sight?
    return false
  end

  def blocked?
    return true
  end

  def can_see_through?
    return false
  end

  def visited?
    return false
  end

  def each
    return []
  end

  def first
    return nil
  end
  
end