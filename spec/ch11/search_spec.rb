
require 'matrix'
require_relative '../spec_helper'

describe "Searching algorithms" do
  before do
    @ary = [1, 3, 6, 10, 15]
  end

  describe "search the first element that larger then key" do
    before do
      @corner_case = [2, 2, 2, 2, 2, 2]
      @corner_case2 = [3, 5, 7]
    end

    it "should raise Argument Error if pass in illegal arguments" do
      expect {Ch11::first_larger(@ary, -1)}.to raise_error(ArgumentError)
    end

    it "should return the first larget element" do
      Ch11::first_larger(@ary, 6).should == 10
    end

    it "should behaive correctly on corner cases" do
      Ch11::first_larger(@corner_case, 2).should == -1
      Ch11::first_larger(@corner_case2, 6).should == 7
    end
  end

  describe "quick select" do
    it "should return the kth element" do
      Ch11::quick_select(@ary, 2).should eql(6)
    end

    it "should return -1 if the kth element doesn't exist" do
      Ch11::quick_select(@ary, 10).should eql(-1)
    end
  end

  describe "binary search" do
    it "should return the element if exist" do
      Ch11::binary_search(@ary, 6).should eql(2)
      Ch11::binary_search(@ary, 11).should eql(-1)
    end
  end

=begin
  describe "search in matrix" do
    before do
      @matrix = Matrix.build(5) {|row, col| 1 + 10 * row + col}
    end

    it "should return the element if exist" do
      Ch11::find_in_matrix(@matrix, 11).should eql([1, 0])
      Ch11::find_in_matrix(@matrix, 10).should eql([-1, -0])
    end
  end
=end
end
