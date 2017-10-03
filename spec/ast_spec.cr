require "./spec_helper.cr"

describe Pegasus::ParseTree do
  it "dumps the contents as expected" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:def) { |p| p.str("def") }
      p.rule(:abcdef) { |p| p.rule(:abc) >> p.rule(:def) }
      p.rule(:abc) { |p| p.str("abc") }

      p.root(:abcdef)
    end

    expected_parse_tree = Pegasus::Branch(String).new(:seq).tap do |tree|
      tree << Pegasus::Leaf.new(:string, "abc")
      tree << Pegasus::Leaf.new(:string, "def")
    end

    res = parser.parse("abcdef")
    res.parse_tree.dump.should eq(expected_parse_tree.dump)
  end
end
