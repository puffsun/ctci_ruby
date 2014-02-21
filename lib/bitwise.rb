
module Bitwise
  def self.get_bit(num, i)
    ((num & (1 << i)) != 0)
  end

  def self.set_bit(num, i)
    num | (1 << i)
  end

  def self.clear_bit(num, i)
    mask = ~(1 << i)
    num & mask
  end

  def self.clear_most_significant_thru_i_bits(num, i)
    mask = (1 << i) - 1
    num & mask
  end

  def self.clear_i_thru_0_bits(num, i)
    mask = ~((1 << (i + 1)) - 1)
    num & mask
  end

  def self.update_bit(num, i, v)
    mask = ~(1 << i)
    (num & mask) | (v << i)
  end
end

if __FILE__ == $0
  num = 0b1001
  puts Bitwise.get_bit(num, 1)
  puts Bitwise.set_bit(num, 2)

  puts Bitwise.clear_bit(num, 0)
  puts Bitwise.update_bit(num, 3, 0)
end
