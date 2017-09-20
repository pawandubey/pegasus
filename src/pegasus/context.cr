module Pegasus
  class Context
    def initialize(@source : String, @pos = 0)
    end

    def consume(string : MatchResultValue)
      @pos += string.size if string
    end

    def rest
      @source[@pos..-1]
    end
  end
end
