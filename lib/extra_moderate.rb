
module Ch17

  # Given a number, count the trailing zeros of the factorial of it.
  def self.count_fact_zeros(num)
    raise ArgumentError if num <= 0
    count = 0
    2.upto(num) do |i|
      count += count_fact_5(i)
    end
    count
  end

  private

  def self.count_fact_5(num)
    count = 0
    while num % 5 == 0
      count += 1
      num /= 5
    end
    count
  end

  public

  # Write a method which finds the maximum of two numbers.
  # You should not use if-else or any other comparison operator.
  def self.get_max(x, y)
    z = x - y
    sx = sign_bit(x)
    sy = sign_bit(y)
    sz = sign_bit(z)

    use_sign_of_x = sx ^ sy
    use_sign_of_z = flip_bit(use_sign_of_x)

    k = use_sign_of_x * sx + use_sign_of_z * sz
    q = flip_bit(k)
    x * q + y * k
  end

  private

  def self.flip_bit(bit)
    1 ^ bit
  end
  # return -1 if negative, 1 if positive
  def self.sign_bit(num)
    (num >> 31) & 1
  end

  public

  Result = Struct.new(:hits, :pseudo_hits)

  def self.master_mind(str_guess, str_solution)
    raise ArgumentError unless str_guess and str_solution
    raise ArgumentError unless str_guess.length == 4 and str_solution.length == 4

    guess_arr = str_guess.split(//)
    solution_arr = str_solution.split(//)
    hits = 0
    pseudo_hits = 0
    0.upto(3) do |i|
      if guess_arr[i].eql?(solution_arr[i]) and !guess_arr[i].nil?
        hits += 1
        guess_arr.delete_at(i)
        solution_arr.delete_at(i)
      end
    end
    guess_arr.each do |e|
      pseudo_hits += 1 if solution_arr.include?(e)
      solution_arr.delete(e)
    end
    Result.new(hits, pseudo_hits)
  end

  # assume array should be sorted by asc
  def self.find_unsorted_sequence(ary)
    raise ArgumentError unless ary
    left = 0, right = ary.size - 1
    1.upto(ary.size - 1) do |i|
      if ary[i - 1] < ary[i]
        left = i
      else
        break
      end
    end

    (ary.size - 2).downto(0) do |i|
      if ary[i + 1] > ary[i]
        right = i
      else
        break
      end
    end

    left_arr = ary.slice(0, left)
    middle_arr = ary.slice(left, right - left + 1)
    right_arr = ary.slice(right + 1, ary.size - right - 1)
    (left_arr.size - 1).downto(0) do |i|
      if left_arr[i] >= middle_arr.min
        left = i
      else
        break
      end
    end

    0.upto(right_arr.size - 1) do |i|
      if right_arr[i] <= middle_arr.max
        right += 1
      else
        break
      end
    end
    [left, right]
  end

  # Given any integer, print an English phrase that describes the integer
  def self.english_of_integer(num)
    raise ArgumentError unless num.is_a?(Integer)
    return "Zero" if num == 0
    return "Negative #{english_of_integer(-num)}" if num < 0

    count = 0
    str = ""
    while num > 0
      if num % 1000 != 0
        str = num_to_str_100(num % 1000) + BIGS[count] + " " + str
      end
      num /= 1000
      count += 1
    end
    str
  end

  private

  DIGITS = %w[One Two Three Four Five Six Seven Eight Nine]
  TEENS = %w[Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen]
  TENS = %w[Ten Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety]
  BIGS = ["", "Thousand", "Million"]

  def self.num_to_str_100(num)
    str = ""
    if num >= 100
      str += DIGITS[num/100 - 1] + " Hundred "
      num %= 100
    end

    if num >= 11 && num <= 19
      return str + TEENS[num - 11] + " "
    elsif num == 10 || num >= 20
      str += TENS[num/10 - 1] + " "
      num %= 10
    end

    if num >= 1 && num <= 9
      str += DIGITS[num - 1] + " "
    end
    str
  end

  public

  # You are given an array of integers (both positive and negative).
  # Find the contiguous sequence with the largest sum. Return the sum.
  def self.max_sum(ary)
    raise ArgumentError unless ary
    sum = max = 0
    ary.inject do |r, e|
      sum += e
      if max < sum
        max = sum
      elsif sum < 0
        sum = 0
      end
    end
    max
  end

  # Best solution to this question in my mind is to sort the array first
  # next, we will search x from left side,
  # then search sum - x from right side
  def self.pair_sum(ary, num)
    raise ArgumentError unless ary
    pairs = {}
    0.upto(ary.size - 1) do |i|
      1.upto(ary.size - 1) do |j|
        pairs[ary[i] + ary[j]] ||= Set.new
        # sort the pair before insert it into result
        pairs[ary[i] + ary[j]] << [ary[i], ary[j]].sort!
      end
    end
    pairs[num]
  end
end
