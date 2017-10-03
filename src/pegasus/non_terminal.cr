module Pegasus
  class NonTerminal < Rule
    def initialize(rule : Rule)
      @children = [] of Rule
      @children << rule
      @label = :nonterm
    end

    def initialize(rule : Rule, alternative : Rule)
      @children = [] of Rule
      @children << rule << alternative
      @label = :nonterm
    end

    def match?(context : Context)
      match = @children.find { |c| c.match?(context)[0].success? }
      if match
        match, context = match.match?(context)
        {MatchResult.success(match.parse_tree), context}
      else
        {MatchResult.failure(Branch(String).new(@label)), context}
      end
    end

    def flatten
      @children
    end
  end
end
