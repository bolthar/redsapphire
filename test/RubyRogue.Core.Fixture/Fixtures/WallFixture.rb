# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'test/unit'

include Core

class WallFixture < Test::Unit::TestCase
   

  def test_always_fillReturnTrue
    wall = Wall.new
    assert(wall.fill?)
  end


end
