
require 'matrix'
require 'set'

module Ch9
  # A child is running up a staircase with n steps, and can hop either 1 step,
  # 2 steps, or 3 steps at a time. Implement a method to count how many
  # possible ways the child can run up the stairs.
  def self.count_ways(n)
    return 0 if n < 0
    return 1 if n == 0
    count_ways(n - 1) + count_ways(n - 2) + count_ways(n - 3)
  end

  # represents a point in the grid
  Point = Struct.new(:x, :y)

  class Grid
    def initialize(grid = Matrix.build(10) {|r, c| 0})
      @grid = grid
    end

    # should the robot move to this point?
    def free?(x, y)
      # no need to check parameters here.
      @grid[x, y] == 0
    end

    def get_paths(x, y, paths = [])
      # start with the destination point
      p = Point.new(x, y)
      return true if x == 0 and y == 0
      success = false

      # try go up
      if x >= 1 and free?(x - 1, y)
        success = get_paths(x - 1, y, paths)
      end

      # try go left
      if !success and y >= 1 and free?(x, y - 1)
        success = get_paths(x, y - 1, paths)
      end
      paths << p if success
      success
    end
  end

  # this method functions properly even with duplicate elements in the array.
  def self.search_magic_index(ary)
    search_magic_index(ary, 0, ary.size - 1)
  end

  def self.search_magic_index(ary, low, high)
    return -1 if (high < low || low < 0 || high >= ary.size)
    mid_index = (low + high) / 2
    mid_value = ary[mid_index]
    return mid_index if mid_index == mid_value

    # search left of middle index
    left_index = [mid_index - 1, mid_value].min
    left = search_magic_index(ary, start, left_index)
    return left if left >= 0

    # search right of middle index
    right_index = [mid_index + 1, mid_value].max
    search_magic_index(ary, right_index, high)
  end

  # all of subsets of the set: http://en.wikipedia.org/wiki/Power_set
  def self.power_set(set)
    result = Set.new
    if set.empty?
      result << Set.new
      return result
    end

    ary = set.to_a
    head = ary.shift
    power_set(ary.to_set).each do |set|
      new_set = Set.new
      new_set << head
      new_set += set
      result << new_set << set
    end
    result
  end

  # find all of permutation of a string
  def self.permutation(str)
    return nil if str.nil?

    result = []
    return result << "" if str.length == 0

    first_char = str[0]
    reminder = str[1..str.size]
    words = permutation(reminder)
    words.each do |w|
      0.upto(w.length) do |i|
        result << w.dup.insert(i, first_char)
      end
    end
    result
  end

  # Given an input file with four billion non-negative integers,
  # provide an algorithm to generate which is not contained in the file.
  # Assume you have 1 GB of memory available for this task.
  # TODO what if we only have 10 MB of memory available
  def find_missing_integer(file)
    raise ArgumentError unless file
    num_ints = 2**31 + 1
    bit_field = Array.new(num_ints / 8) {|e| e = 0}
    file.each_line do |line|
      line.strip.split(' ').each {|n| bit_field[n/8] |= 1 << (n % 8)}
    end

    bit_field.each do |b|
      for i in 0..8 do
        return (b * 8 + i) if ((bit_field[i] & (1 << j)) == 0)
      end
    end
  end

  # Given an array with all the numbers from 1 to N, where N is at most 32000.
  # The array may have duplicate entries and you don't know what N is. With
  # only 4 kilobytes of memory available, how would you print all duplicate
  # elements in the array?
  def find_duplicates(ary)
    raise ArgumentError unless ary
    result = []
    bf = Ch9::BitField.new(32000)
    ary.each do |num|
      actual_num = num - 1
      if bf[actual_num]
        result << num
      else
        bf[actual_num] = 1
      end
    end
    result
  end
end

if __FILE__ == $0
  puts Ch9::count_ways(10)
  set = Set.new
  set << 10 << 20
  puts Ch9::power_set(set).inspect
  puts Ch9::permutation("air").inspect
end
