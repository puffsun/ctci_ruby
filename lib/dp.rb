
require 'pry'
require 'pry-debugger'

module DP
  # On a positive integer, you can perform any one of the following 3 steps.
  #   1.) Subtract 1 from it. (n = n-1),
  #   2.) If its divisible by 2, divide by 2. (if n % 2 == 0, then n = n/2),
  #   3.) If its divisible by 3, divide by 3. (if n % 3 == 0, then n = n/3).
  # Now the question is, given a positive integer n, find the minimum number of steps that takes n to 1
  # eg: 1.) For n = 1, output: 0
  #     2.) For n = 4, output: 2  (4/2 = 2/2 = 1)
  #     3.) For n = 7, output: 3  (7-1 = 6/3 = 2/2 = 1)
  MEMO = []
  def self.get_min_steps(n)
    raise ArgumentError if n < 1
    # base case
    return 0 if n == 1
    return MEMO[n] if MEMO[n]
    steps = 1 + get_min_steps(n - 1)
    steps = [steps, 1 + get_min_steps(n / 2)].min if (n % 2 == 0)
    steps = [steps, 1 + get_min_steps(n / 3)].min if (n % 3 == 0)
    MEMO[n] = steps
    steps
  end

  # the Longest Increasing Subsequence problem is to find the
  # longest increasing subsequence of a given sequence.
  def self.longest_increase_subseq(ary)
    raise ArgumentError unless ary
    # seq[i] - a array, which is the LIS of ary that ends with ary[i]
    seq = Array.new(ary.size) {|e| e = []}
    # seq[0] = [ary[0]], which acts a initial condition
    seq[0] << ary[0]
    # ary[i] = MAX(seq[j] | j < i, ary[j] < ary[i]) + ary[i]
    # https://www.youtube.com/watch?v=4fQJGoeW5VE
    1.upto(ary.size - 1) do |i|
      0.upto(i - 1) do |j|
        if (ary[j] < ary[i]) and (seq[i].size < seq[j].size + 1)
          seq[i] = seq[j].dup
        end
      end
      seq[i] << ary[i]
    end
    seq.max_by {|e| e.size}
  end
end
