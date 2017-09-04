require "./node.cr"

module Pegasus
  class Rule < Node
    def >>(rule : Rule)
      Sequence.new(self, rule)
    end

    def |(rule : Rule)
      NonTerminal.new(self, rule)
    end

    def ==(other)
      self.flatten == other.flatten
    end

    def match?
    end
  end
end
