require "./spec_helper.cr"

describe Pegasus::Position do
  it "initializes with byte_pos, line & column set at 0 by default" do
    pos = Pegasus::Position.new

    pos.byte_position.should eq(0)
    pos.line.should eq(0)
    pos.column.should eq(0)
  end

  it "initializes with custom values for byte_pos, line and col if supplied" do
    line, col, byte = 5, 10, 100
    pos = Pegasus::Position.new(line, col, byte)

    pos.byte_position.should eq(byte)
    pos.line.should eq(line)
    pos.column.should eq(col)
  end

  it "doesn't advance at all if the string is empty" do
    old_pos = Pegasus::Position.new
    pos = old_pos.advance("")

    pos.should eq(old_pos)
  end

  it "advances the byte, line & col count correctly when given a single line string" do
    string = "foo bar"

    pos = Pegasus::Position.new
    pos = pos.advance(string)

    pos.byte_position.should eq(string.size)
    pos.line.should eq(0)
    pos.column.should eq(6)
  end

  it "advances the byte, line and col correctly when given a multiline string" do
    string = "This is a multi\nline string"

    pos = Pegasus::Position.new
    pos = pos.advance(string)

    pos.byte_position.should eq(string.size)
    pos.line.should eq(1)
    pos.column.should eq(10)
  end

  it "advances the line and col for the next given string" do
    string = "foo bar"
    next_string = "This is a multi\nline string"

    pos = Pegasus::Position.new
    first_pos = pos.advance(string)
    second_pos = first_pos.advance(next_string)

    second_pos.byte_position.should eq(string.size + next_string.size)
    second_pos.line.should eq(1)
    second_pos.column.should eq(next_string.lines.last.size - 1)
  end
end
