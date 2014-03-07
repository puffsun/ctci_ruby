
require_relative '../spec_helper'

describe Ch2::LinkedList do
  describe "#new" do
    it {should be_an_instance_of(Ch2::LinkedList)}
    it {should respond_to :head}
    it {should respond_to :find}
    it {should respond_to :remove}
    it {should respond_to :tail}
    it {should respond_to :add}
    it {should respond_to :each}
  end

  describe "Linked List operations" do
    before do
      @list = Ch2::LinkedList.new
      @list.add("d").add("c").add("a").add("b")
    end

    it "should have 4 elements" do
      @list.size.should == 4
      @list.include?("a").should be_true
      @list.include?("d").should be_true
      @list.tail.value.should eql "b"
      @list.head.value.should eql "d"
    end

    it "should support remove operations" do
      @list.remove("a")
      @list.size.should == 3
      @list.include?("a").should be_false
      @list.tail.value.should eql "b"
      @list.head.value.should eql "d"
    end
  end
end
