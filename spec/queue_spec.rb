require_relative "spec_helper"
require_relative "../lib/queue"

describe CTCI::Ch3::Queue do
  let (:queue) {CTCI::Ch3::Queue.new}

  describe "#new" do
    it {should be_empty}
    it {should be_an_instance_of CTCI::Ch3::Queue}
    it {should respond_to :enq}
    it {should respond_to :deq}
    it {should respond_to :empty?}
  end

  describe "queue operations" do
    before do
      queue.enq("a").enq("b").enq("c")
    end

    it "should contains elements enqueued" do
      queue.deq.should eql("a")
      queue.deq.should eql("b")
      queue.deq.should eql("c")
      expect {queue.deq}.to raise_error(StandardError)
    end
  end
end
