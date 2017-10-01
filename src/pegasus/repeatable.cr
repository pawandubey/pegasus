module Pegasus
  module Repeatable
    alias Number = Int32 | UInt64

    def repeat(num : Number)
      Pegasus::Extensions::Repetition.new(self, num, num)
    end

    def repeat(min = UInt64::MIN, max = UInt64::MAX)
      Pegasus::Extensions::Repetition.new(self, min, max)
    end

    def maybe?
      Pegasus::Extensions::Repetition.new(self, 0, 1)
    end
  end
end
