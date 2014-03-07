
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

  describe "find the kthto last element of a singly linked list" do
    before do
      @list = Ch2::LinkedList.new.add("a").add("b").add("c").add("d")
    end

    it "should raise error if passed in illegal arguments" do
      expect {Ch2::last_kth_iterative(@list, -1)}.to raise_error(ArgumentError)
      expect {Ch2::last_kth_recursive(@list, -1, "")}.to raise_error(ArgumentError)
    end

    it "should return correct result" do
      Ch2::last_kth_iterative(@list.head, 2).should eql("b")
    end
  end

  describe "remove current node without access to head" do
    before do
      @list = Ch2::LinkedList.new.add("a").add("b").add("c")
    end

    it "should return nil if node not exist" do
      Ch2::delete_node(nil).should be_nil
    end

    describe "remove the node" do
      before do
        Ch2::delete_node(@list.head.next)
      end

      it "should remove correct node" do
        @list.head.value.should eql("a")
        @list.head.next.value.should eql("c")
        @list.head.next.next.should be_nil
      end
    end
  end
 end
