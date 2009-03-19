# To change this template, choose Tools | Templates
# and open the template in the editor.

module RogueCurses

  class NCursesAdapter

    def initialize(symbols)
      @dictionary = symbols
    end
    
    def dictionary
      return @dictionary      
    end

    def dump(level)

     levelDump = []
      for x in 0...level.width
        levelDump[x] = []
        for y in 0...level.height
          levelDump[x][y] = getCorrectSymbolFromCell(level.at(x,y))
        end
      end
      return levelDump
    end

    def getCorrectSymbolFromCell(cell)
      return @dictionary.emptySymbol if cell.count == 0
      return @dictionary.symbol(cell[0].class)
    end

  end

end
