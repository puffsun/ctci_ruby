
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

  describe "add two numbers in reverse order stored in two linked lists" do

    it "should return correct result with equal size lists" do
      num1 = Ch2::LinkedList.new.add(7).add(1).add(6)
      num2 = Ch2::LinkedList.new.add(5).add(9).add(2)
      result = Ch2::add_lists_reverse(num1.head, num2.head)
      result.value.should == 2
      result.next.value.should == 1
      result.next.next.value.should == 9
      result.next.next.next.should be_nil
    end

    it "should behave correct if list size not equal" do
      num1 = Ch2::LinkedList.new.add(7).add(1)
      num2 = Ch2::LinkedList.new.add(5).add(9).add(9)
      result = Ch2::add_lists_reverse(num1.head, num2.head)
      result.value.should == 2
      result.next.value.should == 1
      result.next.next.value.should == 0
      result.next.next.next.value.should == 1
      result.next.next.next.next.should be_nil
    end
  end

  describe "find the start of loop" do
    before do
      @list = Ch2::LinkedList.new.add("a").add("b").add("c").add("d").add("e")
    end

    it "should return nil if no loop" do
      Ch2::find_beginning_of_loop(@list.head).should be_nil
    end

    it "should return the beginning of loop" do
      @list.tail.next = @list.head.next
      Ch2::find_beginning_of_loop(@list.head).value.should eql("b")
    end
  end

  describe "check if a linked list if palindrome" do

    it "should return true if passed in nil" do
      Ch2::palindrome?(nil).should == true
    end

    it "should return false if list is not palindrome" do
      list = Ch2::LinkedList.new.add("a").add("b").add("c").add("b")
      Ch2::palindrome?(list.head).should == false
    end

    it "should return true if list is palindrome" do
      list = Ch2::LinkedList.new.add("a").add("b").add("c").add("b").add("a")
      Ch2::palindrome?(list.head).should == true
    end
  end
 end
