module Pegasus
  abstract class Node
    abstract def match?(context : Context)
  end
end
