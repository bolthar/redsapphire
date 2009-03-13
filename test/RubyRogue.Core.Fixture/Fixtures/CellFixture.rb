
require 'test/unit'
require 'rubygems'
require 'mocha'

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

  def test_addOperator_RespondToRules_AddToElements
    cell = Cell.new
    object = Object.new
    object.stubs(:rules).returns([])
    result = cell << object
    assert(cell.include? object)
    assert(result)
  end

  def test_each_Always_CycleAllItemsInElements
    cell = Cell.new
    stringone = "1";
    stringtwo = "2";
    stringthree = "3";
    stringone.stubs(:rules).returns(RuleSet.new)
    stringtwo.stubs(:rules).returns(RuleSet.new)
    stringthree.stubs(:rules).returns(RuleSet.new)
    cell << stringone
    cell << stringtwo
    cell << stringthree
    test = ""
    cell.each { |s| test += s }
    assert(test, "123")
  end

   def test_addOperator_elementDoesNotRespondToRules_Raise
    cell = Cell.new
    assert_raise RuntimeError do
      cell << Object.new
    end
   end

   def test_addOperator_rulesCheckreturnFalse_returnFalse
     cell = Cell.new
     rulesetOne = RuleSet.new
     rulesetOne.stubs(:check).returns(false)
     itemOne = stub(:rules => rulesetOne)
     itemTwo = stub(:rules => [])
     cell << itemOne
     result = cell << itemTwo
     assert(!result)
     assert(cell.count == 1)
   end
   

end
