

include Core

class PositionFixture < Test::Unit::TestCase

  def test_ctor_xLessThan0_raise
    assert_raise RuntimeError do
      Position.new(-1,2)
    end
  end

  def test_ctor_yLessThan0_raise
    assert_raise RuntimeError do
      Position.new(2,-1)
    end
  end

  def test_equality_sameXandY_returnTrue
    pos1 = Position.new(1,1)
    pos2 = Position.new(1,1)
    assert(pos1 == pos2)
  end

  def test_equality_sameXdifferentY_returnFalse
    pos1 = Position.new(1,2)
    pos2 = Position.new(1,1)
    assert(!(pos1 == pos2))
  end

  def test_equality_differentXsameY_returnFalse
    pos1 = Position.new(2,1)
    pos2 = Position.new(1,1)
    assert(!(pos1 == pos2))
  end

  def test_equality_differentXdifferentY_returnFalse
    pos1 = Position.new(1,1)
    pos2 = Position.new(2,2)
    assert(!(pos1 == pos2))
  end

  def test_move_okay_returnNewPosition
    position = Position.new(10,10)   
    assert_equal(position.move!(Direction.Up),Position.new(10,9))
  end

  def test_xOffset_returnCorrectValue
    pos1 = Position.new(5,10)
    pos2 = Position.new(12,4)
    assert(pos1.xOffset(pos2) == 7)
    assert(pos2.xOffset(pos1) == -7)
  end

  def test_yOffset_returnCorrectValue
    pos1 = Position.new(5,10)
    pos2 = Position.new(12,4)
    assert(pos1.yOffset(pos2) == -6)
    assert(pos2.yOffset(pos1) == 6)
  end


end

