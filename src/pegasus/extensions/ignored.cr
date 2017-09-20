module Pegasus
  module Extensions
    class Ignored < Pegasus::Rule
      def initialize(@rule : Pegasus::Rule)
      end

      def match?(context : Pegasus::Context)
        old_pos = context.pos
        match = @rule.match?(context)
        context.reset_pos(old_pos)

        match
      end

      def flatten
        [@rule]
      end
    end
  end
end
