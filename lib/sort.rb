
require 'pry'
require 'pry-debugger'

module Ch11
  def self.bubble_sort!(ary)
    raise ArgumentError unless ary
    loop do
      swapped = false
      0.upto(ary.length - 2) do |i|
        if ary[i] > ary[i + 1]
          ary[i], ary[i + 1] = ary[i + 1], ary[i]
          swapped = true
        end
      end
      break unless swapped
    end
    ary
  end

  def self.bubble_sort(ary)
    bubble_sort!(ary.dup)
  end

  def self.selection_sort!(ary)
    (ary.size-1).times do |i|
      min_index = i
      (i+1).upto(ary.size-1) do |j|
        min_index = j if ary[j] < ary[min_index]
      end
      ary[i], ary[min_index] = ary[min_index], ary[i]
    end
    ary
  end

  def self.selection_sort(ary)
    selection_sort!(ary.dup)
  end

  def self.merge_sort(ary)
    merge_sort!(ary.dup)
  end

  def self.merge_sort!(ary)
    return ary if ary.length < 2
    ary1 = ary.slice!(0...(ary.length / 2))
    merge(merge_sort!(ary), merge_sort!(ary1))
  end

  def self.quick_sort!(ary)
    return ary if ary.length < 2
    pivot = ary.pop
    low, high = ary.partition {|e| e < pivot}
    quick_sort!(low) + [pivot] + quick_sort!(high)
  end

  def self.quick_sort(ary)
    quick_sort!(ary.dup)
  end

  # Usually bucket sort is a sorting algorithm for integer (or some other data types)
  # that takes advantage of the fact that integers have a finite number of bits.
  #
  # Below implementation assume that 0..m (m included)is the range of integers in the array,
  # we can also change it a little to pass the lower range into this method.
  #
  # Care should taken that you do not make a off by 1 error.
  def self.bucket_sort!(ary, m, n = ary.length)
    buckets = Array.new(m + 1) {|e| e = 0}
    for i in (0...n)
      buckets[ary[i]] += 1
    end

    i = 0
    for j in 0..m
      buckets[j].times do
        ary[i] = j
        i += 1
      end
    end
    ary
  end

  def self.bucket_sort(ary, m, n = ary.length)
    bucket_sort!(ary.dup, m, n)
  end

  private

  def self.merge(ary1, ary2)
    sorted = []
    until ary1.empty? or ary2.empty?
      ary1.first < ary2.first ? sorted << ary1.shift : sorted << ary2.shift
    end
    sorted + ary1 + ary2
  end
end
