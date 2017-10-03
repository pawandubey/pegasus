module Pegasus
  module Extensions
    class Ignored < Pegasus::Rule
      def initialize(@rule : Pegasus::Rule)
        @label = :ignore
      end

      def match?(context : Pegasus::Context)
        old_context = context.dup
        match, _ = @rule.match?(context)

        {match, old_context}
      end

      def flatten
        [@rule]
      end
    end
  end
end
