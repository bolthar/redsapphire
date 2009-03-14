

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


end

