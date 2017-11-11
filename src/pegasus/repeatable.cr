module Pegasus
  module Repeatable
    alias Number = Int32 | UInt64

    def repeat
      Pegasus::Extensions::Repetition.new(self, 1, UInt64::MAX)
    end

    def repeat(num : Number)
      raise ArgumentError.new("Expected positive. Was #{num}.") if num < 0

      Pegasus::Extensions::Repetition.new(self, num, num)
    end

    def repeat(min : Number, max : Number)
      [min, max].each do |num|
        raise ArgumentError.new("Expected positive. Was #{num}.") if num < 0
      end

      min, max = [min, max].map { |num| num.clamp(UInt64::MIN, UInt64::MAX) }

      Pegasus::Extensions::Repetition.new(self, min, max)
    end

    def at_least(num : Number)
      raise ArgumentError.new("Expected positive. Was #{num}.") if num < 0

      Pegasus::Extensions::Repetition.new(self, num, UInt64::MAX)
    end

    def maybe?
      Pegasus::Extensions::Repetition.new(self, 0, 1)
    end
  end
end
