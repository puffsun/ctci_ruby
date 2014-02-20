require_relative 'spec_helper'
require_relative '../../lib/stack'

describe Ch3::Stack do

  let(:stack) {Ch3::Stack.new}

  describe "#new" do
    it {should be_an_instance_of Ch3::Stack}
    it {should respond_to :pop}
    it {should respond_to :push}
    it {should respond_to :peek}
    it {should respond_to :empty?}
    it {should be_empty}
  end

  describe "stack operations" do
    before do
      stack.push("a").push("b").push("c")
    end
    it "should contains element pushed" do
      stack.peek.should eql("c")
      stack.pop.should eql("c")
      stack.pop.should eql("b")
      stack.pop.should eql("a")
      expect {stack.pop}.to raise_error(StandardError)
    end
  end
end
