module Pegasus
  module Extensions
    class Repetition < Pegasus::Rule
      def initialize(@rule : Node, @min : Number, @max : Number)
        @label = :rep
      end

      def match?(context : Context)
        error = Pegasus::ParseError.new("Max repetitions should be greater than min repetitions for #{@label}.", context.pos)
        return {MatchResult.failure(Leaf.new(@label, ""), error), context} if @min > @max

        occ = 0
        accum = Branch(String).new(@label)

        while occ < @max
          match, context = @rule.match?(context)
          if match.failure?
            return {MatchResult.failure(accum, match.error.not_nil!), context} if occ < @min
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
