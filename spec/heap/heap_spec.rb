
require_relative '../spec_helper'

describe DataStructure::Heap do

  describe "#new" do
    it {should be_an_instance_of DataStructure::Heap}
    it {should respond_to :clear}
    it {should respond_to :size}
    it {should respond_to :extract}
    it {should respond_to :insert}
  end

  describe "heap operations" do
    before do
      # by default this heap is a min heap
      @pq = DataStructure::Heap.new
      @pq.insert(12, 20, 15, 29, 23, 17, 22, 35, 40, 26, 51, 19)
    end

    it "should support basic heap operations" do
      @pq.size.should == 12
      @pq.extract.should == 12
      @pq.size.should == 11
      @pq.insert(13)
      @pq.size.should == 12
      @pq.extract.should == 13
    end
  end
end
