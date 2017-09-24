module Pegasus
  module Atoms
    class String < Base
      getter :str

      def initialize(@str : ::String)
      end

      def match?(context : Context)
        if context.rest.size >= @str.size && context.rest.starts_with?(@str)
          {MatchResult.success(@str), context.consume(@str)}
        else
          {MatchResult.failure(@str), context.dup}
        end
      end

      def ==(other : String)
        @str == other.str
      end
    end
  end
end
