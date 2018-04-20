module Pegasus
  class Terminal < Rule
    def initialize(@atom : Atoms::Base)
      @label = :terminal
    end

    def match?(context : Context)
      match, context = @atom.match?(context)
      if match.success?
        {MatchResult.success(Leaf(String).new(@label, match.parse_tree.value)), context}
      else
        {MatchResult.failure(Leaf(String).new(@label, match.parse_tree.value), match.error.not_nil!), context}
      end
    end

    def flatten
      [@atom]
    end
  end
end
