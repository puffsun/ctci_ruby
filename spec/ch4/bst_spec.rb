
require_relative '../../lib/bst'

describe Ch4::BinSearchTree do
  let(:bst) {Ch4::BinSearchTree.new}

  describe "#new" do
    it {should be_empty}
    it {should be_an_instance_of Ch4::BinSearchTree}
    it {should respond_to :root}
    it {should respond_to :put}
    it {should respond_to :get}
    it {should respond_to :size}
    it {should respond_to :empty?}
    it {should respond_to :delete}
    it {should respond_to :include?}
    it {should respond_to :min}
    it {should respond_to :delete_min}
    it {should respond_to :bst?}

    it {should respond_to :pre_order}
    it {should respond_to :in_order}
    it {should respond_to :post_order}
  end

  describe "Binary Search Tree operations" do
    before do
      bst.put(:b, "b").put(:a, "a").put(:c, "c")
    end
    it "should support normal Binary Search Tree operations" do
      bst.empty?.should be_false
      bst.size.should eql(3)
      bst.include?(:a).should be_true
      bst.include?(:z).should be_false
      bst.bst?.should be_true

      bst.get(:a).should eql("a")
      bst.get(:c).should eql("c")
      bst.get(:z).should be_nil

      bst.root.key.should eql(:b)
      bst.min.should eql(:a)

      # traversal
      bst.pre_order.should eql(["b", "a", "c"])
      bst.in_order.should eql(["a", "b", "c"])
      bst.post_order.should eql(["a", "c", "b"])

      bst.delete(:a)
      bst.size.should eql(2)
      bst.get(:a).should be_nil
      bst.get(:b).should eql("b")
      bst.get(:c).should eql("c")

      bst.delete_min
      bst.get(:b).should be_nil
      bst.size.should eql(1)

    end
  end
end
