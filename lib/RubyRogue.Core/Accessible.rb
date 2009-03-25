# To change this template, choose Tools | Templates
# and open the template in the editor.

module Core
  module Queryable

    def getCells()
      raise "no block passed" unless block_given?

      resultCells = QueryResult.new
      self.each do |element|        
          resultCells << element if yield(element)
        end
      return resultCells
      end


  end

  class QueryResult < Array
    include Queryable

  end


  module Accessible
    include Queryable
    include Enumerable

    def each
      for x in 0...width
        for y in 0...height
          yield @cells[x][y]
        end
      end

    end

    def height
      return @height
    end

    def width
      return @width
    end

    def at(*args)
      if(args.length == 2)
        position = Position.new(args[0],args[1])
      else
        position = args[0]
      end
      return nil unless position
      return nil unless position.x < width
      return nil unless position.y < height
      return @cells[position.x][position.y]
    end



    

    
    
  end
end
