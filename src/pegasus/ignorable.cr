module Pegasus
  module Ignorable
    def ignore
      Pegasus::Extensions::Ignored.new(self)
    end
  end
end
