
class Wall < Entity

  def fill?
    return true
  end

  def can_see_through?
    return false
  end
  
end