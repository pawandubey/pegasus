module Pegasus
  module Extensions
    class Ignored < Pegasus::Rule
      def initialize(@rule : Pegasus::Rule)
        @label = :ignore
      end

      def match?(context : Pegasus::Context)
        old_context = context.dup
        match, context = @rule.match?(context)

        if match.success?
          {MatchResult.success(Leaf.new(@label, match.parse_tree.value)), context}
        else
          {MatchResult.failure(Leaf.new(@label, match.parse_tree.value), match.error.not_nil!), old_context}
        end
      end

      def flatten
        [@rule]
      end
    end
  end
end
