# To change this template, choose Tools | Templates
# and open the template in the editor.


require 'test/unit'
require 'rubygems'
require 'mocha'

include Core

class RuleSetFixture < Test::Unit::TestCase

  def test_always_hasAddOperator
    ruleset = RuleSet.new
    assert(ruleset.respond_to? :<<)
  end

  def test_itemRespondsToCheck_canAddToCollection
    ruleset = RuleSet.new
    item = stub(:check => true)
    ruleset << item
    assert(ruleset.count == 1)
  end

  def test_itemDoesNotRespondToCheck_raise
    ruleset = RuleSet.new
    assert_raise RuntimeError do
      ruleset << Object.new
    end    
  end

  def test_check_callCheckOnEachElement
    ruleset = RuleSet.new
    testItem = Object.new
    firstItem = Object.new
    firstItem.expects(:check).with(testItem).returns(true)
    secondItem = Object.new
    secondItem.expects(:check).with(testItem).returns(true)
    ruleset << firstItem
    ruleset << secondItem
    result = ruleset.check(testItem)
    assert(result)
  end

   def test_check_allRulesTrue_returnTrue
    ruleset = RuleSet.new
    testItem = Object.new
    firstItem = Object.new
    firstItem.stubs(:check).returns(true)
    secondItem = Object.new
    secondItem.stubs(:check).returns(true)
    ruleset << firstItem
    ruleset << secondItem
    result = ruleset.check(testItem)
    assert(result)
  end

   def test_check_oneRuleFalse_returnFalse
    ruleset = RuleSet.new
    testItem = Object.new
    firstItem = Object.new
    firstItem.stubs(:check).returns(true)
    secondItem = Object.new
    secondItem.stubs(:check).returns(false)
    ruleset << firstItem
    ruleset << secondItem
    result = ruleset.check(testItem)
    assert(!result)
  end



end
