
require 'test/unit'
include Core

class CellFixture < Test::Unit::TestCase
  
  def test_foo
    cell = Cell.new
    assert_equal cell.name, "MyName"
  end

end
