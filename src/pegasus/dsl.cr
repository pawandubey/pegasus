module Pegasus
  module DSL
    def str(string : ::String) : Rule
      Terminal.new(Pegasus::Atoms::String.new(string))
    end

    def match(regex : Regex) : Rule
      Terminal.new(Regexp.new(regex))
    end

    def root(name : Symbol) : Rule
      @root = @rules[name]
    end

    def rule(name : Symbol) : Rule
      @rules[name]
    end

    def rule(name : Symbol, &block) : Rule
      @rules[name] = with self yield
    end

    macro define_method(name, &block)
      def {{name.id}}({{block.args.splat}})
        {{block.body}}
      end
    end
  end
end
