module Pegasus
  module Extensions
    class Repetition < Pegasus::Rule
      def initialize(@rule : Node, @min : Number, @max : Number)
        @label = :rep
      end

      def match?(context : Context)
        return {MatchResult.failure(Leaf.new(@label, "")), context} if @min > @max

        occ = 0
        accum = Branch(String).new(@label)

        while occ < @max
          match, context = @rule.match?(context)
          if match.failure?
            return {MatchResult.failure(accum), context} if occ < @min
            return {MatchResult.success(accum), context}
          end

          occ += 1
          accum << match.parse_tree
        end

        return {MatchResult.success(accum), context}
      end

      def flatten
        [@rule, @min, @max]
      end
    end
  end
end
