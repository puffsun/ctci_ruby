
module Ch11

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
end
