module Pegasus
  class ParseError
    def initialize(@msg : ::String, @pos : Pegasus::Position)
    end

    def self.with_details(expected : ::String, got : ::String, pos : Pegasus::Position)
      new("Expected #{expected} to match #{got}", pos)
    end

    def to_s
      @msg + " at line #{@pos.line}, column #{@pos.column}"
    end
  end
end
