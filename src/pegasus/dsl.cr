module Pegasus
  module DSL
    def str(string : ::String) : Rule
      Terminal.new(Pegasus::Atoms::String.new(string))
    end

    def match(regex : Regex) : Rule
      Terminal.new(Pegasus::Atoms::Regexp.new(regex))
    end

    def root(name : Symbol) : Rule
      @root = @rules[name].call(self)
    end

    def rule(name : Symbol) : Rule
      @rules[name].call(self)
    end

    def rule(name : Symbol, &block : Parser -> Rule)
      @rules[name] = block
    end
  end
end
