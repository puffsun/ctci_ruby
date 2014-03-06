
require_relative '../spec_helper'

describe "Sorting algorithms" do
  before do
    @ary = %w[d c b a e]
  end

  describe "bubble sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::bubble_sort(@ary).should eql(%w[a b c d e])
      Ch11::bubble_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "selection sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::selection_sort(@ary).should eql(%w[a b c d e])
      Ch11::selection_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "insertion sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::insertion_sort(@ary).should eql(%w[a b c d e])
      Ch11::insertion_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "merge sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::merge_sort(@ary).should eql(%w[a b c d e])
      Ch11::merge_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "quick sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::quick_sort(@ary).should eql(%w[a b c d e])
      Ch11::quick_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "heap sort" do
    before do
      @ary.shuffle!
    end

    it "should be sorted after sorting" do
      Ch11::heap_sort(@ary).should eql(%w[a b c d e])
      Ch11::heap_sort!(@ary).should eql(%w[a b c d e])
    end
  end

  describe "bucket sort" do
    before do
      @a = [2, 3, 2, 1, 4, 5, 4, 2, 3, 1, 3, 3]
    end

    it "should be sorted after sorting" do
      Ch11::bucket_sort(@a, 5).should eql([1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5])
      Ch11::bucket_sort!(@a, 5).should eql([1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 5])
    end
  end
end
