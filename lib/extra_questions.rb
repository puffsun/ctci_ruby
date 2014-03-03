
require 'pry'
require 'pry-debugger'

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
  # TODO not finish yet
  def self.english_of_integer(num)
    raise ArgumentError unless num.is_a?(Integer)
    return "Zero" if num < 0
    return "Negative #{english_of_integer(-num)}" if num < 0
    result = ""
    if num >= 10**6
      m = num.divmod(10**6)
      result << "#{m[0]} Million "
    end
    if m[1] > 10**3
      t = m[1].divmod(10**3)
      result << "#{t[0]} Thousand "
    end
    if t[1] > 10**2
      h = t[1].divmod(10**2)
      result << "#{h[0]} Hundred "
    end

    result
  end

  private

  DIGITS = %w[One Two Three Four Five Six Seven Eight Nine]
  TEENS = %w[Eleven Twelve Thirteen Fourteen Fifteen Sixteen Seventeen Eighteen Nineteen]
  TENS = %w[Ten Twenty Thirty Forty Fifty Sixty Seventy Eighty Ninety]
  BIGs = %w[Hundred Thousand Million]

  public

end
