
require 'pry'
require 'pry-debugger'
require 'pry-stack_explorer'
require 'treenode'

module Ch4
  class BinaryTree

    attr_accessor :root
    def initialize
      @root = nil
    end

    def empty?
      size == 0
    end

    def size
      size_of_node(@root)
    end

    def size_of_node(node)
      node.nil? ? 0 : node.num_subtree
    end

    def include?(key)
      get(key) != nil
    end

    def get(key, node = @root)
      return nil if node.nil?
      if key < node.key
        get(key, node.left)
      elsif key > node.key
        get(key, node.right)
      else
        node.value
      end
    end

    def put(key, value)
      @root = put_to_node(@root, key, value)
      self
    end

    def put_to_node(node, key, value)
      return TreeNode.new(key, value, 1) if node.nil?
      if key < node.key
        node.left = put_to_node(node.left, key, value)
      elsif key > node.key
        node.right = put_to_node(node.right, key, value)
      else
        node.value = value
      end
      node.num_subtree = size_of_node(node.left) + size_of_node(node.right) + 1
      node
    end

    def pre_order(node = @root)
      result = []
      return result unless node
      result << node.value
      result << pre_order(node.left)
      result << pre_order(node.right)
      result.flatten!
    end

    def in_order(node = @root)
      result = []
      return result unless node
      result << in_order(node.left)
      result << node.value
      result << in_order(node.right)
      result.flatten!
    end

    def post_order(node = @root)
      result = []
      return result if node.nil?
      result << post_order(node.left)
      result << post_order(node.right)
      result << node.value
      result.flatten!
    end

    def balanced?(node = @root)
      return true if node.nil?
      return false if node.left.nil? && !node.right.nil?
      return false if node.right.nil? && !node.left.nil?
      (node.left.num_subtree - node.right.num_subtree).abs <= 1
    end
  end
end
