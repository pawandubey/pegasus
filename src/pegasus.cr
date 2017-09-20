require "./pegasus/context.cr"
require "./pegasus/match_result.cr"
require "./pegasus/node.cr"
require "./pegasus/repeatable.cr"
require "./pegasus/ignorable.cr"
require "./pegasus/rule.cr"
require "./pegasus/terminal.cr"
require "./pegasus/non_terminal.cr"
require "./pegasus/sequence.cr"
require "./pegasus/atoms/*"
require "./pegasus/extensions/*"

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
