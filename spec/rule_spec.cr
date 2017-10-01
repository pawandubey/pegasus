require "./spec_helper"

describe Pegasus::Rule do
  it "combines operators properly" do
    a = construct_rule(Pegasus::Atoms::String)
    b = construct_rule(Pegasus::Atoms::String)
    c = construct_rule(Pegasus::Atoms::String)
    d = construct_rule(Pegasus::Atoms::String)

    comb = a | b >> c | d

    comb.should be_a(Pegasus::Rule)

    expected_comb = Pegasus::NonTerminal.new(
      Pegasus::NonTerminal.new(construct_rule(Pegasus::Atoms::String),
        Pegasus::Sequence.new(
          construct_rule(Pegasus::Atoms::String),
          construct_rule(Pegasus::Atoms::String)
        )),
      construct_rule(Pegasus::Atoms::String)
    )

    comb.should eq(expected_comb)
  end
end
