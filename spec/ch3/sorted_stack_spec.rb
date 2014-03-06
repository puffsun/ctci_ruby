
require_relative '../spec_helper'

describe Ch3::Stacks do
  it "should not be instantiated" do
    expect {Ch3::Stacks.new}.to raise_error(NoMethodError)
    Ch3::Stacks.should respond_to :sort
  end

  describe "sort a stack" do
    before do
      @s = Ch3::Stack.new
      @s.push(20).push(10).push(30).push(15)
    end

    it "should be sorted" do
      sorted = Ch3::Stacks.sort(@s)
      sorted.pop.should eql(30)
      sorted.pop.should eql(20)
      sorted.pop.should eql(15)
      sorted.pop.should eql(10)
    end
  end
end
