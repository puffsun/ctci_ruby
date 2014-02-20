
require_relative '../../lib/stack'

describe Ch3::MinStack do
  let(:ms) {Ch3::MinStack.new}

  describe "#new" do
    it {should be_an_instance_of Ch3::MinStack}
    it {should be_empty}
    it {should respond_to :push}
    it {should respond_to :pop}
    it {should respond_to :peek}
    it {should respond_to :empty?}
    it {should respond_to :min}
  end

  describe "min should return min element" do
    before do
      ms.push(10)
      ms.push(20)
      ms.push(5)
      ms.push(30)
    end

    it "should be min" do
      ms.min.should eql(5)
      ms.pop.should eql(30)
    end
  end
end
