module Pegasus
  class MatchResult
    getter :parse_tree

    def initialize(@result : Bool, @parse_tree : Pegasus::Tree)
    end

    def self.success(tree : Pegasus::Tree)
      MatchResult.new(true, tree)
    end

    def self.failure(tree : Pegasus::Tree)
      MatchResult.new(false, tree)
    end

    def success?
      @result
    end

    def failure?
      !success?
    end
  end
end
