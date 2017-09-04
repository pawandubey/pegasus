module Pegasus
  module Atoms
    class String < Base
      getter :str

      def initialize(@str : ::String)
      end

      def match?(str : ::String)
        @str == str
      end

      def ==(other : String)
        @str == other.str
      end
    end
  end
end
