require "./spec_helper"

describe Pegasus::Parser do
  it "returns a new Parser instance on define" do
    result = Pegasus::Parser.define { }
    result.should be_a(Pegasus::Parser)
  end

  it "creates a rules" do
    parser = Pegasus::Parser.define do
      rule(:abc) { str("abc") }
      rule(:def) { str("def") }
      rule(:abcdef) { rule(:abc) >> rule(:def) }
    end

    parser.rules.size.should eq(3)
  end

  it "parses strings" do
    parser = Pegasus::Parser.define do
      rule(:abc) { str("abc") }
      rule(:def) { str("def") }
      rule(:abcdef) { rule(:abc) >> rule(:def) }

      root(:abcdef)
    end

    parser.parse("abcdef").should be_truthy
  end
end
