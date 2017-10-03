module Pegasus
  abstract class Node
    include Pegasus::Repeatable
    include Pegasus::Ignorable

    getter :label

    abstract def match?(context : Context)

    def initialize
      @label = :node
    end

    def aka(label : Symbol)
      @label = label.not_nil!
      self
    end
  end
end
