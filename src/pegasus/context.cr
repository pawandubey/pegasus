module Pegasus
  class Context
    getter :pos

    def initialize(@source : ::String, @pos = Pegasus::Position.new)
    end

    def consume(string : ::String)
      pos = @pos.advance(string)
      Context.new(@source, pos)
    end

    def rest
      return "" if @pos.byte_position >= @source.size
      @source[@pos.byte_position..-1]
    end

    private def reset_pos(pos)
      @pos = pos
    end
  end
end
