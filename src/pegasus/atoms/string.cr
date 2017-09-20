require "./base.cr"

module Pegasus
  module Atoms
    class String < Base
      getter :str

      def initialize(@str : ::String)
      end

      def match?(context : Context)
        if context.rest.starts_with?(@str)
          context.consume(@str)
          MatchResult.success(@str)
        else
          MatchResult.failure(@str)
        end
      end

      def ==(other : String)
        @str == other.str
      end
    end
  end
end
