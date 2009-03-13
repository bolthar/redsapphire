# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

include Core

class WallFixture < Test::Unit::TestCase
  
  def test_wall_always_respondsToRules
    wall = Wall.new
    assert(wall.respond_to? :rules)
  end

  def test_always_rulesCheckReturnFalse
    wall = Wall.new
    assert(wall.rules.count == 1)
    assert(!wall.rules.check(nil))
  end

  

end
