module Pegasus
  class MatchResult
    getter :parse_tree

    def initialize(@result : Bool, @parse_tree : Pegasus::ParseTree)
    end

    def self.success(tree : Pegasus::ParseTree)
      MatchResult.new(true, tree)
    end

    def self.failure(tree : Pegasus::ParseTree)
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
