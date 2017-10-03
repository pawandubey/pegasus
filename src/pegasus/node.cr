module Pegasus
  abstract class Node
    include Pegasus::Repeatable
    include Pegasus::Ignorable

    getter :label

    abstract def match?(context : Context)
  end
end
