module Pegasus
  class Parser
    include Pegasus::DSL

    @root : Rule | Nil
    getter :rules, :root

    private def initialize
      @rules = {} of Symbol => Rule
      @root = nil
    end

    def self.define() : Pegasus::Parser
      parser = new
      with parser yield
      parser
    end

    def parse(string : ::String)
      ctx = Context.new(string)
      res, _ = @root.not_nil!.match?(ctx)
      res
    end
  end
end
