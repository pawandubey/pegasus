require "../spec_helper"

describe Pegasus::Atoms::String do
  it "matches similar strings" do
    string = Pegasus::Atoms::String.new("match_me")
    result, _ = string.match?(Pegasus::Context.new("match_me"))
    result.success?.should be_true
  end

  it "doesn't match dissimilar strings" do
    string = Pegasus::Atoms::String.new("match_me")
    result, _ = string.match?(Pegasus::Context.new("dont_match_me"))
    result.success?.should be_false
  end

  it "should be equal to another String with the same matcher" do
    string = Pegasus::Atoms::String.new("match_me")
    another_string = Pegasus::Atoms::String.new("match_me")

    string.should eq(another_string)
  end

  it "shouldn't be equal to another string with different matcher" do
    string = Pegasus::Atoms::String.new("match_me")
    another_string = Pegasus::Atoms::String.new("dont_match_me")

    string.should_not eq(another_string)
  end

  it "matches repeat occurances for exact times" do
    string = Pegasus::Atoms::String.new("a").repeat(3)
    result, _ = string.match?(Pegasus::Context.new("aaa"))
    result.success?.should be_true
    result.parse_tree.value.should eq("aaa")
  end

  it "fails if doesn't match exact times" do
    string = Pegasus::Atoms::String.new("a").repeat(3)
    result, _ = string.match?(Pegasus::Context.new("aa"))
    result.success?.should be_false
    result.parse_tree.value.should eq("aa")
  end

  it "matches indefinitely if not supplied with a limit" do
    string = Pegasus::Atoms::String.new("a").repeat
    result, _ = string.match?(Pegasus::Context.new("aaa"))
    result.success?.should be_true
    result.parse_tree.value.should eq("aaa")
  end

  it "matches repeat occurances exact times even if there are more to match" do
    string = Pegasus::Atoms::String.new("a").repeat(3)
    result, _ = string.match?(Pegasus::Context.new("aaaaaa"))
    result.success?.should be_true
    result.parse_tree.value.should eq("aaa")
  end

  it "matches occurances within the limits" do
    string = Pegasus::Atoms::String.new("a").repeat(3, 5)
    result, _ = string.match?(Pegasus::Context.new("aaaa"))
    result.success?.should be_true
    result.parse_tree.value.should eq("aaaa")
  end

  it "matches the possible presence when present" do
    string = Pegasus::Atoms::String.new("a").maybe?
    result, _ = string.match?(Pegasus::Context.new("a"))
    result.success?.should be_true
    result.parse_tree.value.should eq("a")
  end

  it "matches the possible presence when absent" do
    string = Pegasus::Atoms::String.new("a").maybe?
    result, _ = string.match?(Pegasus::Context.new("bcd"))
    result.success?.should be_true
    result.parse_tree.value.should eq("")
  end

  it "matches the ignored value" do
    context = Pegasus::Context.new("aaabcd")
    string = Pegasus::Atoms::String.new("a").repeat(3).ignore
    result, context = string.match?(context)
    result.success?.should be_true
    result.parse_tree.value.should eq("aaa")
    context.rest.should eq("bcd")
  end

  it "redefines label with aka" do
    string = Pegasus::Atoms::String.new("match_me")

    string.label.should eq(:string)
    string.aka(:abc)
    string.label.should eq(:abc)
  end
end
