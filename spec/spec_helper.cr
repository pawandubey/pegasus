require "spec"
require "../src/pegasus"

def construct_rule(klass : Pegasus::Atoms::Base.class)
  case klass
  when Pegasus::Atoms::String.class
    atom = Pegasus::Atoms::String.new("some string")
    Pegasus::Terminal.new(atom)
  else
    atom = Pegasus::Atoms::Regexp.new(/\d+/)
    Pegasus::Terminal.new(atom)
  end
end
