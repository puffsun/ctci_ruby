
module Ch17
  class BiNode
    attr_accessor :left, :right

    def +(node)
      return self unless node
    end

    def tail
    end

    def head
    end
  end

  def self.convert_to_bi_linkedlist(root)
    return nil if root.nil?
    left = convert_to_bi_linkedlist(root.left)
    right = convert_to_bi_linkedlist(root.right)
    left + root + right
  end
end
