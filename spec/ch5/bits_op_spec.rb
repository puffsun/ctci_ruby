
require_relative '../../lib/bits_op'

describe "insert m bits from i to j in n bits" do
  it "should give the correct result" do
    n = 0b10000000000
    m = 0b10011
    i = 2
    j = 6
    Ch5::update_bits(n, m, i, j).should eql(0b10001001100)
  end

  it "should print binary representation of double between 0 and 1" do
    #Ch5::print_bin(0.101).should eql("")
  end

  it "should return number of bits required to convert integer a to b" do
    Ch5::bits_required(31, 14).should eql(2)
  end

  it "should swap odd bits and even bits" do
    Ch5::swap_odd_even_bits(10).should eql(5)
  end
end
