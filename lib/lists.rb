
module Ch2

  def self.circular?(node)
    return false if node.nil?
    slower = node; faster = node.next
    while true
      if faster.nil? || faster.next.nil?
        return false
      elsif faster == slower || faster.next == slower
        return true
      else
        # move forward
        slower = slower.next
        faster = faster.next.next
      end
    end
  end

  # find the kth to the last element of a singly linked list
  # there's no size of the linked list information stored.
  def self.last_kth_recursive(node, k, result)
    raise ArgumentError if k <= 0
    return 0 if node.nil?
    index = last_kth_recursive(node.next, k, result) + 1
    puts node.value if k == index
    index
  end

  # Traverse the singly linked list with two iteraters
  def self.last_kth_iterative(node, k)
    raise ArgumentError unless node && k > 0
    p1 = node; p2 = node
    k.times do
      return nil if p2.nil?
      p2 = p2.next
    end
    return nil if p2.nil?
    until p2.next.nil?
      p1 = p1.next
      p2 = p2.next
    end
    p1.value
  end

  # Implement an algorithm to delete a node in the
  # middle of a singuly linked list.
  # given only access to that node
  def self.delete_node(node)
    # to achieve this, we need to copy next node to
    # current node, then delete next node instead
    return nil if node.nil? or node.next.nil?
    node.value = node.next.value
    node.next = node.next.next
  end

  # write code to partition a linked list around a value x,
  # such that all nodes less than x come before
  # all nodes greater than or equal x
  def self.partition(node, key)
    before_start = after_start = nil
    until node.nil?
      n = node.next
      break if n.nil?
      if n.value < key
        n.next = before_start
        before_start = n
      else
        n.next = after_start
        after_start = n
      end
      node = n
    end

    return after_start if before_start.nil?
    head = before_start
    unless before_start.next.nil?
      before_start = before_start.next
    end
    before_start.next = after_start
    head
  end

  class Node
    attr_accessor :value, :next

    def initialize(value = nil)
      @value = value
    end

    def append(v)
      n = self
      while n.next
        n = n.next
      end
      n.next = Node.new(v)
      self
    end

    def to_s
      @value
    end
  end

  class LinkedList

    include Enumerable
    attr_reader :head

    def initialize(head = nil)
      @head = Node.new(head) if head
      @size = 0
    end

    def size
      @size
    end

    def add(value)
      if head.nil?
        @head = Node.new(value)
      else
        prev_node = cur_node = @head
        while cur_node
          prev_node = cur_node
          cur_node = cur_node.next
        end
        cur_node = Node.new(value)
        prev_node.next = cur_node
      end
      @size += 1
      self
    end

    def find(value)
      node(value) ? true : false
    end

    def tail
      prev_node = cur_node = @head
      while cur_node
        prev_node = cur_node
        cur_node = cur_node.next
      end
      prev_node
    end

    def remove(value)
      return nil if @head.nil?
      if @head.value == value
        @head = @head.next
      else
        cur_node = prev_node = @head
        while cur_node
          cur_node = cur_node.next
          if cur_node.value == value
            prev_node.next = cur_node.next
            @size -= 1
            return value
          else
            prev_node = cur_node
          end
        end
        nil
      end
    end

    def each(&block)
      tmp_node = @head
      size.times do
        yield tmp_node.value if block
        tmp_node = tmp_node.next
      end
    end

    def to_s
      return "" unless @head
      cur_node = @head
      result = []
      result << cur_node.value
      cur_node = cur_node.next
      while cur_node
        result << "->"<< cur_node.value
        cur_node = cur_node.next
      end
      result.join(" ")
    end

    def node(value)
      cur_node = @head
      while cur_node
        return cur_node if cur_node.value == value
        cur_node = cur_node.next
      end
      nil
    end
  end
end
