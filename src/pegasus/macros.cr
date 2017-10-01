module Pegasus
  module Macros
    macro define_method(name, &block)
      def {{name.id}}({{block.args.splat}})
        {{block.body}}
      end
    end

    def self.yield_with_context(context)
      with context yield
    end

    macro capture_with_context(context, &block)
      -> { Macros.yield_with_context {{context}} {{block}} }
    end
  end
end
