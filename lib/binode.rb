
module Ch17
  class BiNode
    attr_accessor :prev_node, :next_node

    def +(node)
      return self unless node
      tail.next_node = node
      node.prev_node = tail
    end

    def tail
      return self unless next_node
      tmp_node = self
      until tmp_node.next_node.nil?
        tmp_node = tmp_node.next_node
      end
      tmp_node
    end

    def head
      return self unless prev_node
      tmp_node = self
      until tmp_node.prev_node.nil?
        tmp_node = tmp_node.prev_node
      end
      tmp_node
    end
  end

  def self.convert_to_bi_linkedlist(root)
    return nil if root.nil?
    left = convert_to_bi_linkedlist(root.prev_node)
    right = convert_to_bi_linkedlist(root.right_node)
    left + root + right
  end
end
