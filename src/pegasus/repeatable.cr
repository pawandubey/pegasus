module Pegasus
  module Repeatable
    alias Number = Int32 | UInt64

    def repeat(num : Number)
      raise ArgumentError.new("Expected positive. Was #{num}.") if num < 0

      Pegasus::Extensions::Repetition.new(self, num, num)
    end

    def repeat(min = 0, max = UInt64::MAX)
      [min, max].each do |num|
        raise ArgumentError.new("Expected positive. Was #{num}.") if num < 0
      end

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
