module Pegasus
  class Sequence < Rule
    def initialize(head : Rule, *tail)
      @seq = [] of Rule
      @seq << head
      @seq = @seq + tail.to_a
      @label = :seq
    end

    def match?(context : Context)
      tree = @seq.reduce(Branch(String).new(@label)) do |acc, rule|
        match, context = rule.match?(context)
        return {MatchResult.failure(match.parse_tree), context} if match.failure?

        acc << match.parse_tree
        acc
      end

      {MatchResult.success(tree), context}
    end

    def flatten
      @seq
    end
  end
end
