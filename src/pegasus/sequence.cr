require "./rule.cr"

module Pegasus
  class Sequence < Rule
    def initialize(head : Rule, *tail)
      @seq = [] of Rule
      @seq << head
      @seq = @seq + tail.to_a
    end

    def match?(args)
      @seq.all? { |rule| rule.match?(args) }
    end

    def flatten
      @seq
    end
  end
end
