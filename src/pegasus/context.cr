module Pegasus
  class Context
    getter :pos

    def initialize(@source : String, @pos = 0)
    end

    def consume(string : ::String)
      pos = @pos
      pos += string.size if string
      Context.new(@source, pos)
    end

    def rest
      return "" if @pos >= @source.size
      @source[@pos..-1]
    end

    private def reset_pos(pos)
      @pos = pos
    end
  end
end
