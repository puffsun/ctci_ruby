
require_relative '../spec_helper'

describe Ch3::AnimalQueue do
  let(:animal_q) {Ch3::AnimalQueue.new}

  describe "#new" do
    it {should be_empty}
    it {should be_an_instance_of Ch3::AnimalQueue}
    it {should respond_to :enq}
    it {should respond_to :deq_dog}
    it {should respond_to :deq_cat}
    it {should respond_to :deq_any}
    it {should respond_to :empty?}
  end

  describe "Animal adoption" do
    before do
      animal_q.enq(Ch3::Cat.new("Tom")).enq(Ch3::Dog.new("Jerry")).enq(Ch3::Cat.new("Terry")).enq(Ch3::Dog.new("Tim"))
    end

    it "should return any animal type that user specified or any one" do
      animal_q.deq_dog.name.should eql("Jerry")
      animal_q.deq_any.name.should eql("Tom")
      animal_q.deq_cat.name.should eql("Terry")
    end
  end
end
