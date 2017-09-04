module Pegasus
  module Atoms
    class Regexp < Base
      getter :regex

      def initialize(@regex : Regex)
      end

      def match?(str : ::String)
        @regex.match(str)
      end

      def ==(other : self)
        @regex == other.regex
      end
    end
  end
end
