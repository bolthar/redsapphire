# To change this template, choose Tools | Templates
# and open the template in the editor.

module RogueCurses
  
  class SymbolsDictionary

    def initialize
      @dictionary = {}
      @dictionary[:emptySymbol] = "."
      @dictionary[Wall] = "#"
      @dictionary[Door] = "+"
    end

    def symbol(classPointer)
      return @dictionary[classPointer]
    end

    def emptySymbol
      return @dictionary[:emptySymbol]
    end


  end

end
