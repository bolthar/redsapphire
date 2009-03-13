

module Core
  
  class Wall

    def initialize
      @rules = RuleSet.new
      @rules << NoPassRule.new
    end

    def rules
      return @rules
    end

  end

end
