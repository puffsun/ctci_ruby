
require_relative '../../lib/queue'

describe Ch3::MyQueue do
  let(:my_queue) {Ch3::MyQueue.new}

  describe "#new" do
    it {should be_empty}
    it {should be_an_instance_of Ch3::MyQueue}
    it {should respond_to :enq}
    it {should respond_to :deq}
    it {should respond_to :empty?}
    it {should respond_to :size}
  end

  describe "queue operations" do
    before do
      my_queue.enq(1).enq(2).enq(3)
    end
    it "should support normal queue operations" do
      my_queue.deq.should eql(1)
      my_queue.deq.should eql(2)
      my_queue.deq.should eql(3)
      expect {my_queue.deq}.to raise_error(StandardError)
    end
  end
end
