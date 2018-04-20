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
      matched_node = @children.find do |c|
        c.match?(context)[0].success?
      end

      if matched_node
        match, context = matched_node.match?(context)
        {MatchResult.success(match.parse_tree), context}
      else
        error = @children.last.match?(context)[0].error.not_nil!

        {MatchResult.failure(Branch(String).new(@label), error), context}
      end
    end

    def flatten
      @children
    end
  end
end
