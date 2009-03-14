# To change this template, choose Tools | Templates
# and open the template in the editor.

include LevelBuilder::Workers

class LevelFillerFixture < Test::Unit::TestCase
  
  def test_fillLevel_always_returnLevelFilledWithWalls
    filler = LevelFiller.new
    level = Level.new(100,100)
    filler.fillLevel!(level)
    for x in 0...100
      for y in 0...100
        assert(false) unless level.at(x,y)[0].kind_of? Wall
      end
    end
    
  end

end
