
require_relative '../../lib/stack'

describe Ch3::SetOfStacks do
  let(:sos) {Ch3::SetOfStacks.new(3)}

  describe "#new" do
    context "threshold should be default to 100" do
      before do
        s = Ch3::SetOfStacks.new
        s.instance_variable_get("@threshold").should eql(100)
      end
    end

    context "with threshold specified" do
      it "should respond to stack operations" do
        sos.should be_empty
        sos.should be_an_instance_of Ch3::SetOfStacks
        sos.should respond_to :push
        sos.should respond_to :pop
        sos.should respond_to :peek
        sos.should respond_to :empty?
      end
    end
  end

  describe "normal stack operations" do
    before do
      sos.push("a").push("b").push("c").push("d")
    end

    it "should behave like normal stack" do
      sos.instance_variable_get("@stacks").size.should eql(2)
      sos.pop.should eql("d")
      sos.pop.should eql("c")
      sos.instance_variable_get("@stacks").size.should eql(1)
      sos.pop.should eql("b")
      sos.pop.should eql("a")
      expect {sos.pop}.to raise_error(StandardError)
    end
  end

  describe "pop_at operation" do
    before do
      sos.push("a").push("b").push("c").push("d").push("e")
    end

    it "should support pop at specified stack" do
      sos.pop_at(0).should eql("c")
      sos.pop_at(1).should eql("e")
    end
  end
end
