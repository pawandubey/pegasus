require "./base.cr"

module Pegasus
  module Atoms
    class Regexp < Base
      getter :regex

      @match_data : ::String | Nil

      def initialize(@regex : Regex)
      end

      def match?(context : Context)
        res = @regex.match(context.rest)
        if res
          @match_data = res.not_nil!.to_a.compact.join
          context.consume(@match_data)
          MatchResult.success(@match_data)
        else
          MatchResult.failure(@match_data)
        end
      end

      def ==(other : self)
        @regex == other.regex
      end
    end
  end
end
