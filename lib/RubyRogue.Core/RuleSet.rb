

module Core
  class RuleSet < Array

    def <<(item)
     raise "Item does not respond to checkl method" unless item.respond_to? :check
     
     super(item)
    end

    
  end
end
