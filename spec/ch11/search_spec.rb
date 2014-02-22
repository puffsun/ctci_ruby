
require 'matrix'
require_relative '../../lib/search'

describe "Searching algorithms" do

  describe "binary search" do
    before do
      @ary = %w[1 3 6 10 15]
    end

    it "should return the element if exist" do
      Ch11::binary_search(@ary, "6").should eql(2)
      Ch11::binary_search(@ary, "11").should eql(-1)
    end
  end

=begin
  describe "search in matrix" do
    before do
      @matrix = Matrix.build(5) {|row, col| 1 + 10 * row + col}
    end

    it "should return the element if exist" do
      Ch11::find_in_matrix(@matrix, 11).should eql([1, 0])
      Ch11::find_in_matrix(@matrix, 10).should eql([-1, -0])
    end
  end
=end
end
