module Pegasus
  module Atoms
    abstract class Base < Node
      getter :match_data

      abstract def match?(context : Context) : MatchResult
    end
  end
end
