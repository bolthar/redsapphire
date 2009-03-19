
include RogueCurses

class NCursesAdapterFixture < Test::Unit::TestCase

  def test_ctor_assignSymbolDictionaryToDictionay
    symbols = stub()
    adapter = NCursesAdapter.new(symbols)
    assert(adapter.dictionary == symbols)   
  end

  def test_dump_allEmptyLevel_callEmptySymbol
    dictionary = mock
    dictionary.expects(:emptySymbol).times(100).returns("-")
    level = Level.new(10,10)
    adapter = NCursesAdapter.new(dictionary)
    dump = adapter.dump(level)   
    assert(dump.count == 10)
    for i in 0...dump.count do
      assert(dump[i].count == 10)
      for j in 0...dump[i].count do
        assert(dump[i][j] == "-")
      end
    end
  end

  def test_dump_widthOneWall_callrightStuff
    dictionary = mock
    dictionary.expects(:emptySymbol).times(99).returns(".")
    dictionary.expects(:symbol).with() { |value| value == Wall}.returns("#")
    level = Level.new(10,10)
    level.at(4,1) << Wall.new
    adapter = NCursesAdapter.new(dictionary)
    dump = adapter.dump(level)
    assert(dump.count == 10)
    for i in 0...dump.count do
      assert(dump[i].count == 10)
      for j in 0...dump[i].count do
        if i == 4 && j == 1
          assert(dump[i][j] == "#")
        else
          assert(dump[i][j] == ".")
        end
      end
    end
  end

  def test_dump_withOneDoor_callrightStuff
    dictionary = mock
    dictionary.expects(:emptySymbol).times(99).returns(".")
    dictionary.expects(:symbol).with() { |value| value == Door}.returns("+")
    level = Level.new(10,10)
    level.at(4,7) << Door.new
    adapter = NCursesAdapter.new(dictionary)
    dump = adapter.dump(level)
    assert(dump.count == 10)
    for i in 0...dump.count do
      assert(dump[i].count == 10)
      for j in 0...dump[i].count do
        if i == 4 && j == 7
          assert(dump[i][j] == "+")
        else
          assert(dump[i][j] == ".")
        end
      end
    end
  end

end
