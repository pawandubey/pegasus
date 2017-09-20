module Pegasus
  class NonTerminal < Rule
    def initialize(rule : Rule)
      @children = [] of Rule
      @children << rule
    end

    def initialize(rule : Rule, alternative : Rule)
      @children = [] of Rule
      @children << rule << alternative
    end

    def match?(context : Context)
      match = @children.find { |c| c.match?(context).success? }
      if match
        match = match.match?(context)
        MatchResult.success(match.value)
      else
        MatchResult.failure("")
      end
    end

    def flatten
      @children
    end
  end
end
