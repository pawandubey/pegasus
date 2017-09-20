module Pegasus
  module Extensions
    class Repetition < Pegasus::Rule
      def initialize(@rule : Node, @min : Number, @max : Number)
      end

      def match?(context : Context)
        return MatchResult.failure("") if @min > @max

        occ = 0
        accum = ""

        while occ < @max
          match = @rule.match?(context)
          if match.failure?
            return MatchResult.failure(accum) if occ < @min
            return MatchResult.success(accum)
          end

          occ += 1
          accum += match.value
        end

        return MatchResult.success(accum)
      end

      def flatten
         [@rule, @min, @max]
      end
    end
  end
end
