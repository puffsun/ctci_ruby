
module Ch4
  class TreeNode
    # num_subtree   count of sub-tree nodes
    attr_accessor :key, :value, :left, :right, :num_subtree

    def initialize(key, value, num)
      @key = key
      @value = value
      @num_subtree = num
    end
  end
end
