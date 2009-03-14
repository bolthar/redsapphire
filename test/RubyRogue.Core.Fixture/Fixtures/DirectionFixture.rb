# To change this template, choose Tools | Templates
# and open the template in the editor.

include Core

class DirectionFixture < Test::Unit::TestCase

  def test_ctor_xLessthanminusOne_raise
    assert_raise RuntimeError do
      Direction.new(-2,0)
    end
  end

  def test_ctor_xMorethanOne_raise
    assert_raise RuntimeError do
      Direction.new(2,0)
    end
  end

  def test_ctor_yLessthanminusOne_raise
    assert_raise RuntimeError do
      Direction.new(0,-2)
    end
  end

  def test_ctor_yMorethanOne_raise
    assert_raise RuntimeError do
      Direction.new(0,2)
    end
  end

  def test_Up_always_returnCorrectDirection
    up = Direction.Up
    assert(up.x == 0)
    assert(up.y == -1)
  end

  def test_UpRight_always_returnCorrectDirection
    up = Direction.UpRight
    assert(up.x == 1)
    assert(up.y == -1)
  end

  def test_Right_always_returnCorrectDirection
    up = Direction.Right
    assert(up.x == 1)
    assert(up.y == 0)
  end

  def test_DownRight_always_returnCorrectDirection
    up = Direction.DownRight
    assert(up.x == 1)
    assert(up.y == 1)
  end

  def test_Down_always_returnCorrectDirection
    up = Direction.Down
    assert(up.x == 0)
    assert(up.y == 1)
  end

  def test_DownLeft_always_returnCorrectDirection
    up = Direction.DownLeft
    assert(up.x == -1)
    assert(up.y == 1)
  end

  def test_Left_always_returnCorrectDirection
    up = Direction.Left
    assert(up.x == -1)
    assert(up.y == 0)
  end

  def test_UpLeft_always_returnCorrectDirection
    up = Direction.UpLeft
    assert(up.x == -1)
    assert(up.y == -1)
  end

  def test_cardinalLeft_startingRightLEft_returnCorrectDirection
    up = Direction.Right.cardinalLeft
    assert(up == Direction.Up)
  end

   def test_cardinalLeft_startingUpDown_returnCorrectDirection
    right = Direction.Down.cardinalLeft
    assert(right == Direction.Right)
  end
  
  def test_cardinalRight_startingRightLEft_returnCorrectDirection
    down = Direction.Right.cardinalRight
    assert(down == Direction.Down)
  end

  def test_cardinalRight_startingUpDown_returnCorrectDirection
    left = Direction.Down.cardinalRight
    assert(left == Direction.Left)
  end

  def test_opposite_onCardinal_returnCorrectDirection
    left = Direction.Right.opposite
    assert(left == Direction.Left)
  end
  
  def test_opposite_returnCorrectDirection
    downLeft = Direction.UpRight.opposite
    assert(downLeft == Direction.DownLeft)
  end

  def test_left_returnCorrectDirection
    upRight = Direction.Right.left
    assert(upRight == Direction.UpRight)
  end

  def test_right_returnCorrectDirection
    downRight = Direction.Right.right
    assert(downRight == Direction.DownRight)
  end

  def test_isCardinal_notCardinal_returnFalse
    upRight = Direction.UpRight
    assert(!upRight.isCardinal?)
  end

   def test_isCardinal_Cardinal_returnTrue
    up = Direction.Up
    assert(up.isCardinal?)
  end

  
end
