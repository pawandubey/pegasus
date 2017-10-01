require "./spec_helper"

describe Pegasus::Parser do
  it "returns a new Parser instance on define" do
    result = Pegasus::Parser.define { }
    result.should be_a(Pegasus::Parser)
  end

  it "creates a rules" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:abc) { |p| p.str("abc") }
      p.rule(:def) { |p| p.str("def") }
      p.rule(:abcdef) { |p| p.rule(:abc) >> p.rule(:def) }
    end

    parser.rules.size.should eq(3)
  end

  it "parses strings" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:def) { |p| p.str("def") }
      p.rule(:abcdef) { |p| p.rule(:abc) >> p.rule(:def) }
      p.rule(:abc) { |p| p.str("abc") }

      p.root(:abcdef)
    end

    parser.parse("abcdef").success?.should be_true
    parser.parse("def").failure?.should be_true
  end
end
