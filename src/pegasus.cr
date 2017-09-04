require "./pegasus/*"

module Pegasus
  def self.rule(name, &block)
    define_method({{name}}) do
      {{block.body}}
    end
  end

  macro define_method(name, &block)
    def {{name}}
      {{block.body}}
    end
  end
end
