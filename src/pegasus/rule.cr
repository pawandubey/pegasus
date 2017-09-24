module Pegasus
  class Rule < Node
    include Pegasus::Ignorable
    include Pegasus::Repeatable

    def >>(rule : Rule)
      Sequence.new(self, rule)
    end

    def |(rule : Rule)
      NonTerminal.new(self, rule)
    end

    def ==(other : Rule)
      self.flatten == other.flatten
    end

    def flatten
    end

    def match?(context : Context) : {MatchResult, Context}
      {MatchResult.failure(""), Context.new("")}
    end
  end
end
