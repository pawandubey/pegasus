module Pegasus
  class MatchResult
    getter :parse_tree, :error

    def initialize(@result : Bool, @parse_tree : Pegasus::ParseTree, @error : Pegasus::ParseError? = nil)
      @parse_tree = parse_tree.prune
    end

    def self.success(tree : Pegasus::ParseTree)
      MatchResult.new(true, tree)
    end

    def self.failure(tree : Pegasus::ParseTree, error : Pegasus::ParseError)
      MatchResult.new(false, tree, error)
    end

    def success?
      @result
    end

    def failure?
      !success?
    end
  end
end
