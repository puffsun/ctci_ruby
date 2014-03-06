
require_relative "../spec_helper"

describe Ch17::BiNode do

  describe "#new" do
    it {should be_an_instance_of(Ch17::BiNode)}
    it {should respond_to(:head)}
    it {should respond_to(:tail)}
  end
end

describe "convert to binary linked list" do
  before do
    #@bst = build_bst([5, 10, 2, 9, 3, 6, 4])
  end

  it "should return nil with nil argument" do
    Ch17::convert_to_bi_linkedlist(nil).should be_nil
  end
end
