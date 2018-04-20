require "./pegasus/position.cr"
require "./pegasus/context.cr"
require "./pegasus/parse_error.cr"
require "./pegasus/match_result.cr"
require "./pegasus/repeatable.cr"
require "./pegasus/ignorable.cr"
require "./pegasus/node.cr"
require "./pegasus/rule.cr"
require "./pegasus/terminal.cr"
require "./pegasus/non_terminal.cr"
require "./pegasus/sequence.cr"
require "./pegasus/atoms/*"
require "./pegasus/extensions/*"
require "./pegasus/macros.cr"
require "./pegasus/dsl.cr"
require "./pegasus/parser.cr"
require "./pegasus/ast.cr"

module Pegasus
  alias Number = Int32 | UInt64
  alias ParseTree = Leaf(String) | Branch(String)
end
