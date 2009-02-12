
require 'test/unit'
include Core

class CellFixture < Test::Unit::TestCase

  def test_shouldrespond_toeach
    cell = Cell.new
    assert(cell.respond_to? :each)
  end

  def test_shouldrespond_tocomparer
    cell = Cell.new
    assert(cell.respond_to? :<=>)
  end

  def test_shouldrespond_toaddoperator
    cell = Cell.new
    assert(cell.respond_to? :<<)
  end

  def test_addOperator_Always_AddToElements
    cell = Cell.new
    object = Object.new
    cell << object
    assert(cell.include? object)
  end

  def test_each_Always_CycleAllItemsInElements
    cell = Cell.new
    stringone = "1";
    stringtwo = "2";
    stringthree = "3";
    cell << stringone
    cell << stringtwo
    cell << stringthree
    test = ""
    cell.each { |s| test += s }
    assert(test, "123")
  end

  def test_symbol_emptyElements_ReturnStringEmpty
    cell = Cell.new
    assert_equal(cell.symbol , "")
  end

  def test_symbol_someElements_returnLastInserted
    cell = Cell.new
    cell << "a"
    cell << "c"
    cell << "b"
    assert_equal(cell.symbol, "b")
  end
end
