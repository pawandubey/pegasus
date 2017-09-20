module Pegasus
  module Atoms
    abstract class Base < Node
      getter :match_data
      include Pegasus::Repeatable
      include Pegasus::Ignorable

      abstract def match?(context : Context) : MatchResult
    end
  end
end
