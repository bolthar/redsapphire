

module Core

  class RuleSet < Array

    def <<(rule)
     raise "Item does not respond to check method" unless rule.respond_to? :check
     super(rule)
    end

    def check(item)
      self.each { |element|
        return false unless element.check(item)
       }
      return true
    end    
    
   end

end
