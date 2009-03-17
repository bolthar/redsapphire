# To change this template, choose Tools | Templates
# and open the template in the editor.


include Core

class LevelFixture < Test::Unit::TestCase

  def test_ctor_setHeightAndWidth
    level = Level.new(100,100)
    assert(level.height == 100)
    assert(level.width == 100)
  end

  def test_level_always_respondtoAt
    level = Level.new(100,100)
    assert(level.respond_to? :at)
  end

  def test_at_WidthoutOfBounds_returnNil
    level = Level.new(100,200)
    assert(!level.at(100,100)) # goes from 0 to 99
  end

  def test_at_HeightOutOfBounds_Raise
    level = Level.new(200,100)
    assert(!level.at(100,100)) #goes from 0 to 99
  end

  def test_ctor_generateCellsForEachLocation
    level = Level.new(100,100)
    for width in 0...99
      for height in 0...99
        assert(false) unless level.at(width,height)
      end
    end
  end

  def test_at_inBounds_returnCell
    level = Level.new(100,100)
    cell = level.at(0,0)
    assert(cell.kind_of? Cell) #should use respond_to?
  end
  
  

end
