
require 'pry'

module Ch11

  # given a sorted array,
  # find the first element that larger than key
  def self.first_larger(ary, key, low = 0, high = ary.length - 1)
    raise ArgumentError unless ary and key > 0
    return ary[low] if (low > high) and (low < ary.size)
    mid = (low + high) / 2
    if ary[mid] == key
      cur_index = mid
    elsif ary[mid] < key
      return first_larger(ary, key, mid + 1, high)
    else
      return first_larger(ary, key, low, mid - 1)
    end

    while (cur_index + 1 < ary.size) and (ary[cur_index + 1] == ary[cur_index])
      cur_index += 1
    end
    return ary[cur_index + 1] if ary[cur_index + 1] != nil
    -1
  end

  # select the kth element
  def self.quick_select(ary, k)
    return -1 if k > ary.size
    arr = ary.dup
    loop do
      pivot = arr.delete_at(rand(arr.length))
      left, right = arr.partition {|x| x < pivot}
      if k == left.length
        return pivot
      elsif k < left.length
        arr = left
      else
        k = k - left.length - 1
        arr = right
      end
    end
  end

  def self.binary_search(ary, item, low = 0, high = ary.length - 1)
    return -1 if low > high
    mid = (low + high) / 2
    if ary[mid] == item
      return mid
    elsif ary[mid] > item
      binary_search(ary, item, mid + 1, high)
    else
      binary_search(ary, item, 0, mid - 1)
    end
  end

  #def self.find_in_matrix(matrix, item)
  #end
end
