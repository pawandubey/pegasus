module Pegasus
  class Position
    getter :line, :column, :byte_position

    def initialize(@line : Pegasus::Number = UInt64::MIN, @column : Pegasus::Number = UInt64::MIN, @byte_position : Pegasus::Number = UInt64::MIN)
    end

    def advance(str : ::String)
      next_byte_position = byte_position + str.size

      lines = str.lines
      last_line = lines.empty? ? "" : lines.last

      next_line = line + clamp_to_zero(lines.size - 1)
      next_col = line_advanced?(next_line) ? reset_and_advance_col(last_line) : advance_col(last_line)

      Position.new(next_line, next_col, next_byte_position)
    end

    def ==(other : Position)
      [line, column] == [other.line, other.column]
    end

    private def line_advanced?(next_line)
      next_line > line
    end

    private def reset_and_advance_col(last_line)
      clamp_to_zero(last_line.size - 1)
    end

    private def advance_col(last_line)
      column + clamp_to_zero(last_line.size - 1)
    end

    private def clamp_to_zero(num : Pegasus::Number)
      num.clamp(UInt64::MIN, UInt64::MAX)
    end
  end
end
