module Pegasus
  class Context
    getter :pos

    def initialize(@source : String, @pos = 0)
    end

    def consume(string : MatchResultValue)
      @pos += string.size if string
    end

    def rest
      return "" if @pos >= @source.size
      @source[@pos..-1]
    end

    def reset_pos(pos)
      @pos = pos
    end
  end
end
