
include Core
include LevelBuilder::Workers

class ItemPopulatorFixture < Test::Unit::TestCase

  def test_populate_Items_setItemsCorrectly()
    itemPopulator = ItemPopulator.new
    level = Level.new(10,10)
    itemPopulator.populate(level,10)
    items = 0
    for x in 0...10
      for y in 0...10
        items += level.at(x,y).count
      end
    end
    assert_equal(10,items)
  end
end
