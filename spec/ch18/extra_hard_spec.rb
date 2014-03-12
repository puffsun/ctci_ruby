
require_relative '../spec_helper'

describe "Extra question, hard" do
  describe "adding two numbers without using arithmetic operators" do
    it "should return correct result" do
      Ch18::add(1, 2).should == 3
    end
  end
end
