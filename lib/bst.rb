
=begin
require 'pry'
require 'pry-debugger'
require 'pry-stack_explorer'
=end
require 'treenode'

module Ch4
  class BinSearchTree

    attr_reader :root

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

    def put(key, value)
      @root = put_to_node(@root, key, value)
      self
    end

    def put_to_node(node, key, value)
      return TreeNode.new(key, value, 1) if node.nil?
      cmp = (key <=> @root.key)
      if cmp > 0
        node.right = put_to_node(node.right, key, value)
      elsif cmp < 0
        node.left = put_to_node(node.left, key, value)
      else
        node.value = value
      end
      node.num_subtree = size_of_node(node.left) + size_of_node(node.right) + 1
      node
    end

    def get(key)
      return get_node(@root, key)
    end

    def get_node(node, key)
      return nil unless node
      cmp = (key <=> node.key)
      if cmp > 0
        return get_node(node.right, key)
      elsif cmp < 0
        return get_node(node.left, key)
      else
        return node.value
      end
    end

    def delete(key)
      @root = delete_node(@root, key)
    end

    def delete_node(node, key)
      return nil unless node
      cmp = (key <=> node.key)
      if cmp > 0
        node.right = delete_node(node.right, key)
      elsif cmp < 0
        node.left = delete_node(node.left, key)
      else
        # if right child is not exist, replace with its left sub tree
        return node.left if node.right.nil?
        # if left child is not exist, replace with its right sub tree
        return node.right if node.left.nil?
        # below is the most tricky part of the whole Binary Search Tree data structure.
        # The solution here is first proposed by T. Hibbard in 1962.
        # You can refer to: http://en.wikipedia.org/wiki/Binary_search_tree#Deletion
        n = node
        node = min_node(n.right)
        node.right = delete_min(n.right)
        node.left = n.left
      end
      node.num_subtree = size_of_node(node.left) + size_of_node(node.right) + 1
      node
    end

    def min
      return nil if empty?
      return min_node(@root).key
    end

    def min_node(node)
      return node if node.left.nil?
      return min_node(node.left)
    end

    def delete_min
      @root = delete_min_node(@root)
    end

    def delete_min_node(node)
      return node.right if node.left.nil?
      node.left = delete_min_node(node.left)
      node.num_subtree = size(node.left) + size(node.right) + 1
      return node
    end

    def include?(key)
      get(key) != nil
    end

    def pre_order(node = @root)
      result = []
      return result unless node
      result << node.value
      result << pre_order(node.left)
      result << pre_order(node.right)
      result.flatten
    end

    def in_order(node = @root)
      result = []
      return result unless node
      result << in_order(node.left)
      result << node.value
      result << in_order(node.right)
      result.flatten
    end

    def post_order(node = @root)
      result = []
      return result if node.nil?
      result << post_order(node.left)
      result << post_order(node.right)
      result << node.value
      result.flatten
    end
  end

end
