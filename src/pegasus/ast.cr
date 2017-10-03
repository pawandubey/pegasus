module Pegasus
  alias Tree = Leaf | Branch

  class Leaf
    getter :label

    def initialize(@label : Symbol, @item : ::String)
    end

    def value
      @item
    end
  end

  class Branch
    getter :label, :children

    def initialize(@label : Symbol)
      @children = [] of Tree
    end

    def value
      String.build do |str|
        @children.reduce(str) do |accum, child|
          accum << child.value
        end
      end
    end

    def <<(tree : Tree)
      @children << tree
    end
  end
end
