require "../spec_helper"

describe Pegasus::Atoms::String do
  it "matches similar strings" do
    string = Pegasus::Atoms::String.new("match_me")
    string.match?("match_me").should be_true
  end

  it "doesn't match dissimilar strings" do
    string = Pegasus::Atoms::String.new("match_me")
    string.match?("dont_match_me").should be_false
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
end
