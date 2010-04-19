
class Monster < Entity

  def take_damage
    @hp -= 1
    p @hp
    @dead.call if @hp == 0
  end

end