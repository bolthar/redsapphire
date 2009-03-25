
include Core

class CellFixture < Test::Unit::TestCase

  def test_shouldrespond_toeach
    cell = Cell.new(nil,0,0)
    assert(cell .respond_to? :each)
  end

  def test_shouldrespond_tocomparer
    cell = Cell.new(nil,0,0)
    assert(cell.respond_to? :<=>)
  end

  def test_shouldrespond_toaddoperator
    cell = Cell.new(nil,0,0)
    assert(cell.respond_to? :<<)
  end

  def test_addOperator_RespondToRules_AddToElements
    cell = Cell.new(nil,0,0)
    object = Object.new
    object.stubs(:fill?).returns(false)
    result = cell << object
    assert(cell.include? object)
    assert(result)
  end

  def test_each_Always_CycleAllItemsInElements
    cell = Cell.new(nil,0,0)
    stringone = "1";
    stringtwo = "2";
    stringthree = "3";
    stringone.stubs(:fill?).returns(false)
    stringtwo.stubs(:fill?).returns(false)
    stringthree.stubs(:fill?).returns(false)
    cell << stringone
    cell << stringtwo
    cell << stringthree
    test = ""
    cell.each { |s| test += s }
    assert(test, "123")
  end


  def test_addOperator_itemAddedNotRespondToFill_raise
    cell = Cell.new(nil,0,0)
    assert_raise RuntimeError do
      cell << Object.new
    end

  end

   def test_addOperator_rulesCheckreturnFalse_returnFalse
     cell = Cell.new(nil,0,0)
     itemOne = stub(:fill? => true)
     itemTwo = stub(:fill? => false)
     cell << itemOne
     result = cell << itemTwo
     assert(!result)
     assert(cell.count == 1)
   end
   

end
