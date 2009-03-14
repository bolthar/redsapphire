# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core::Elements

class DoorFixture < Test::Unit::TestCase

  def test_ctor_defaultState_filled
    door = Door.new
    assert(door.fill?)
  end

  def test_open_alwaysChangeFillToFalse
    door = Door.new
    door.open
    assert(!door.fill?)
  end

  def test_close_alwaysChangeFillToTrue
    door = Door.new
    door.open
    door.close
    assert(door.fill?)
  end



end