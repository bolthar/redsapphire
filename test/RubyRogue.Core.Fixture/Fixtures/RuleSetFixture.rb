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

end
