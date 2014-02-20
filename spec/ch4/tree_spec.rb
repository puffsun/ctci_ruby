
require_relative '../../lib/tree'

describe Ch4::BinaryTree do
  let(:bt) {Ch4::BinaryTree.new}

  describe "#new" do
    it {should be_an_instance_of Ch4::BinaryTree}
    it {should be_empty}
    it {should respond_to :empty?}
    it {should respond_to :size}
    it {should respond_to :include?}
    it {should respond_to :get}
    it {should respond_to :put}
    it {should respond_to :pre_order}
    it {should respond_to :in_order}
    it {should respond_to :post_order}
    it {should respond_to :balanced?}
  end

  describe "perform Binary Tree operations" do
    before do
      bt.put(:b, "b").put(:a, "a").put(:c, "c")
    end

    it "should support Binary Tree operations" do
      bt.size.should eql(3)
      bt.empty?.should be_false
      bt.get(:a).should eql("a")
      bt.get(:c).should eql("c")
      bt.get(:z).should be_nil

      # traversal
      bt.pre_order.should eql(["b", "a", "c"])
      bt.in_order.should eql(["a", "b", "c"])
      bt.post_order.should eql(["a", "c", "b"])

      bt.balanced?.should be_true
      bt.put(:d, "d").put(:e, "e")
      bt.balanced?.should be_false
    end
  end
end
