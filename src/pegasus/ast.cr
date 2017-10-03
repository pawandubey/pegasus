require "json"

module Pegasus
  alias ParseTree = Leaf(String) | Branch(String)

  class Leaf(T)
    getter :label

    def initialize(@label : Symbol, @item : T)
    end

    def value
      @item
    end

    def dump
      to_json
    end

    JSON.mapping(
      label: Symbol,
      item: T
    )
  end

  class Branch(T)
    getter :label, :children

    def initialize(@label : Symbol)
      @children = [] of Leaf(T) | Branch(T)
    end

    def value
      String.build do |str|
        @children.reduce(str) do |accum, child|
          accum << child.value
        end
      end
    end

    def <<(tree : Leaf(T) | Branch(T))
      @children << tree
    end

    def dump
      to_json
    end

    JSON.mapping(
      label: Symbol,
      children: Array(Branch(T) | Leaf(T))
    )
  end
end
