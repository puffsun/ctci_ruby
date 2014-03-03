
require 'pry'
require 'pry-debugger'

module Ch11

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
