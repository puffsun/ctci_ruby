
require_relative '../spec_helper'

include Helper

describe "Linked list related algorithms" do
  describe "detect a circular linked list" do
    before do
      @circular_list = build_singular_linked_list(%w[c d a b d])
      @non_circular_list = build_singular_linked_list(%w[c d a b d])
    end

    it "should return true if linked list is circular" do
      Ch2::circular?(@circular_list).should == true
    end

    it "should return false if linked list is acyclic" do
      Ch2::circular?(@non_circular_list).should == false
    end
  end
end
