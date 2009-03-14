# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder
include LevelBuilder::Workers
include Core

class SplitterFixture < Test::Unit::TestCase

  def test_split_always_returnsAMatrixOfZones
    splitter = Splitter.new(5,5)
    zones = splitter.split(Level.new(100,100))
    assert(false) unless zones.respond_to? :[]
    zones.each do |row|
      assert(false) unless row.respond_to? :[]
    end
    assert(true)
  end

  def test_split_undivisiblewidth_raise
    splitter = Splitter.new(3,5)
    assert_raise RuntimeError do
      splitter.split(Level.new(100,100))
    end
  end

  def test_split_undivisibleheight_raise
    splitter = Splitter.new(5,3)
    assert_raise RuntimeError do
      splitter.split(Level.new(100,100))
    end
  end

  def test_split_correctMatrixDimension
    splitter = Splitter.new(5,5)
    zones = splitter.split(Level.new(100,100))
    assert(false) unless zones.count == 5
    zones.each do |column|
      assert(false) unless column.count == 5
    end
    assert(true)
  end
end
