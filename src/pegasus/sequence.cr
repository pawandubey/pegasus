require "./rule.cr"

module Pegasus
  class Sequence < Rule
    def initialize(head : Rule, *tail)
      @seq = [] of Rule
      @seq << head
      @seq = @seq + tail.to_a
    end

    def match?(context : Context)
      match_data = @seq.reduce("") do |acc, rule|
        match = rule.match?(context)
        return MatchResult.failure(match.value) if match.failure?

        acc + match.value
      end

      MatchResult.success(match_data)
    end

    def flatten
      @seq
    end
  end
end
