
require_relative 'spec_helper'
require_relative '../lib/stack'

describe Ch3::ThreeStacks do
  let(:ts) {Ch3::ThreeStacks.new}

  describe "#new" do
    it {should be_empty}
    it {should respond_to(:push)}
    it {should respond_to(:pop)}
    it {should respond_to(:empty?)}
    it {should respond_to(:peek)}
  end

  describe "three stacks' operations" do
    before do
      ts.push("a", 0).push("b", 1).push("c", 2)
      ts.push("d", 0).push("e", 1).push("f", 2)
    end

    it "should support three stacks' operations" do
      expect {ts.pop(-1)}.to raise_error(StandardError)
      expect {ts.pop(3)}.to raise_error(StandardError)
      ts.pop(0).should eql("d")
      ts.pop(1).should eql("e")
      ts.pop(2).should eql("f")
      ts.pop(0).should eql("a")
      expect {ts.pop(0)}.to raise_error(StandardError)
    end
  end
end





