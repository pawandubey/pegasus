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
      tree << Pegasus::Leaf.new(:terminal, "abc")
      tree << Pegasus::Leaf.new(:terminal, "def")
    end

    res = parser.parse("abcdef")
    res.parse_tree.dump.should eq(expected_parse_tree.dump)
  end

  it "renames the nodes with #aka" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:def) { |p| p.str("def") }
      p.rule(:abcdef) { |p| p.rule(:abc).aka(:a2c) >> p.rule(:def).aka(:d2f) }
      p.rule(:abc) { |p| p.str("abc") }

      p.root(:abcdef)
    end

    expected_parse_tree = Pegasus::Branch(String).new(:seq).tap do |tree|
      tree << Pegasus::Leaf.new(:a2c, "abc")
      tree << Pegasus::Leaf.new(:d2f, "def")
    end

    res = parser.parse("abcdef")
    res.parse_tree.dump.should eq(expected_parse_tree.dump)
  end

  it "ignores ignored nodes while still matching" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:def) { |p| p.str("def") }
      p.rule(:abcdef) { |p| p.rule(:abc).aka(:a2c) >> p.rule(:def).ignore }
      p.rule(:abc) { |p| p.str("abc") }

      p.root(:abcdef)
    end

    expected_parse_tree = Pegasus::Branch(String).new(:seq).tap do |tree|
      tree << Pegasus::Leaf.new(:a2c, "abc")
    end

    res = parser.parse("abcdef")
    res.parse_tree.dump.should eq(expected_parse_tree.dump)
  end

  it "repeats nodes as expected" do
    parser = Pegasus::Parser.define do |p|
      p.rule(:abc) { |p| p.str("abc").aka(:abc) }
      p.rule(:abc3) { |p| p.rule(:abc).repeat(3) }

      p.root(:abc3)
    end

    expected_parse_tree = Pegasus::Branch(String).new(:rep).tap do |tree|
      tree << Pegasus::Leaf.new(:abc, "abc")
      tree << Pegasus::Leaf.new(:abc, "abc")
      tree << Pegasus::Leaf.new(:abc, "abc")
    end

    res = parser.parse("abcabcabc")
    res.parse_tree.dump.should eq(expected_parse_tree.dump)
  end
end
