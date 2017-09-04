require "./rule.cr"

module Pegasus
  class NonTerminal < Rule
    def initialize(rule : Rule)
      @children = [rule]
    end

    def initialize(rule : Rule, alternative : Rule)
      @children = [rule, alternative]
    end

    def match?(args)
      @children.find { |c| c.match?(args) }
    end

    def flatten
      @children
    end
  end
end
