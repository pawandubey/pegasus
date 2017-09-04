require './atoms/*'

module Pegasus
  class Terminal < Rule
    def initialize(@atom : Atoms::Base)
    end

    def match?(args)
      @atom.match?(args)
    end

    def flatten
      [@atom]
    end
  end
end
