module Pegasus
  module Atoms
    class Regexp < Base
      getter :regex

      def initialize(@regex : Regex)
        @label = :regexp
      end

      def match?(context : Context)
        res = @regex.match(context.rest)
        if res
          match_data = res.not_nil!.to_a.compact.join
          node = Pegasus::Leaf(::String).new(@label, match_data)
          {MatchResult.success(node), context.consume(match_data)}
        else
          node = Pegasus::Leaf(::String).new(@label, "")
          error = Pegasus::ParseError.with_details(@regex.inspect, context.rest, context.pos)
          {MatchResult.failure(node, error), context}
        end
      end

      def ==(other : self)
        @regex == other.regex
      end
    end
  end
end
