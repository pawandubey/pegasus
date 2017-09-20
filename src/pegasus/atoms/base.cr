require "../match_result.cr"

module Pegasus
  module Atoms
    abstract class Base
      getter :match_data
    end
  end
end
