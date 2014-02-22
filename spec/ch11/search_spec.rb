
require_relative '../../lib/search'

describe "Searching with binary search" do
    before do
      @ary = %w[1 3 6 10 15]
    end
  it "should return specified element if exist" do
    Ch11::binary_search(@ary, "6").should eql(2)
    Ch11::binary_search(@ary, "11").should eql(-1)
  end
end
