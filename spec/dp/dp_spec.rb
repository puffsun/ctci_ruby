
require_relative '../spec_helper'
require_relative '../../lib/dp'

describe "Dynamic Programming Problems" do
  describe "Minimum steps to one" do
    it "should raise ArgumentError if n is lower then 1" do
      expect{DP::get_min_steps(0)}.to raise_error(ArgumentError)
    end

    it "should output 0 if n is 1" do
      DP::get_min_steps(1).should == 0
    end

    it "should output 2 if n is 4" do
      DP::get_min_steps(4).should == 2
    end

    it "should output 3 if n is 7" do
      DP::get_min_steps(7).should == 3
    end
  end

  describe "Longest Increasing Subsequence" do
    before do
      @ary = [3, 2, 6, 4, 5, 1]
    end

    it "should raise ArgumentError if passed in nil" do
      expect {DP::longest_increase_subseq(nil)}.to raise_error(ArgumentError)
    end

    it "should find the longest subsequence" do
      DP::longest_increase_subseq(@ary).should eql([2, 4, 5])
    end
  end
end
