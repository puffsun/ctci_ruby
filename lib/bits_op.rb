
module Ch5
  # Given two 32-bits numbers, N and M, and two bit positions, i and j.
  # Write a program to insert M into N such that M starts at bit j and end at bit i.
  def self.update_bits(n, m, i, j)
    all_ones = ~0
    # 11100000
    left = all_ones << (j + 1)
    # 00000011
    right = ((1 << j) - 1)
    mask = left | right
    n_cleared = n & mask
    m_shifted = m << i
    n_cleared | m_shifted
  end

  #??? float number binary representation
  def self.print_bin(num)
    return "ERROR" if (num >= 1 || num <= 0)
    result = ""
    result << "."
    frac = 0.5
    while (num > 0)
      return "ERROR" if result.length > 32

      if num >= frac
        result << "1"
        num -= frac
      else
        result << "0"
      end
      frac /= 2
    end
  end

  # Write a function to determine the number of bits required to convert integer A to integer B.
  def self.bits_required(a, b)
    # xor returns the different between the inputs
    xor = a ^ b
    count = 0
    until xor == 0
      count += 1
      # clear the least significant bit
      xor = xor & (xor - 1)
    end
    count
  end

  def self.swap_odd_even_bits(num)
    ((num & 0xaaaaaaaa) >> 1) | ((num & 0x55555555) << 1)
  end
end

if __FILE__ == $0
  puts Ch5::print_bin(0.101)
  puts Ch5::print_bin(0.72)
end
