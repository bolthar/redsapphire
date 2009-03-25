
include Core::Elements

class PlayerTest < Test::Unit::TestCase

  def test_fill_always_returnFalse
    player = Player.new
    assert(!player.fill?)
  end

  def test_collide_withDoor_callOpenOnDoor
    door = mock()
    door.expects(:kind_of?).returns(true)
    door.expects(:open)
    player = Player.new
    player.collide(door)
  end


end
