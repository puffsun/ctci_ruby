
require_relative '../spec_helper'

describe "Linked list related algorithms" do
  describe "detect a circular linked list" do
    before do
      @circular_list = Ch2::LinkedList.new.add("a").add("b").add("c")
      @circular_list.tail.next = @circular_list.head
      @non_circular_list = Ch2::LinkedList.new.add("c").add("b").add("a")
    end

    it "should return true if linked list is circular" do
      Ch2::circular?(@circular_list.head).should == true
    end

    it "should return false if linked list is acyclic" do
      Ch2::circular?(@non_circular_list.head).should == false
    end

    it "should return false for nil argument" do
      Ch2::circular?(nil).should == false
    end
  end
end
