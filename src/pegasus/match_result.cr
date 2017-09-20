module Pegasus
  alias MatchResultValue = ::String | Nil

  class MatchResult
    getter :value

    def initialize(@result : Bool, @value : MatchResultValue)
    end

    def self.success(matched_value : MatchResultValue)
      MatchResult.new(true, matched_value)
    end

    def self.failure(matched_value : MatchResultValue)
      MatchResult.new(false, matched_value)
    end

    def success?
      @result
    end

    def failure?
      !success?
    end
  end
end
