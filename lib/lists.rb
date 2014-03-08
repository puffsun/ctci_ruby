
module Ch2

  # detect if a linked list is circular
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

  # You have two numbers represented by a linked list,
  # where each node contains a single digit.
  # The digits are stored in reverse order,
  # such that the Ts digit is at the head of the list.
  # Write a function that adds the two numbers and
  # returns the sum as a linked list.
  # Input:(7-> 1 -> 6) + (5 -> 9 -> 2). That is, 617 + 295.
  # Output: 2 -> 1 -> 9. That is, 912.
  def self.add_lists_reverse(node1, node2, carry = 0)
    return nil if node1.nil? && node2.nil? && carry == 0
    value = carry
    value += node1.value unless node1.nil?
    value += node2.value unless node2.nil?
    result = Node.new(value % 10)
    unless node1.nil? && node2.nil?
      next_node = add_lists_reverse(node1.nil? ? nil : node1.next,
                            node2.nil? ? nil : node2.next,
                            value >= 10 ? 1 : 0)
      result.next = next_node
    end
    result
  end

  # same question as above, but the numbers stores in forward order
  # Input: (6 -> 1 -> 7) + (2 -> 9 -> 5). That is, 617 + 295.
  # Output: 9 -> 1 -> 2. That is, 912.
  #
  # Solution 1: we can reverse the original linked lists
  # Then reverse the result again
  #
  # Solution 2: 1). padding the short list
  #             2). insert successive value before the previous one,
  #                 but first we need to find the right position.
  def self.add_lists(node1, node2, carry = 0)
    len1 = length(node1)
    len2 = length(node2)
    if len1 > len2
      node1 = pad_list(node1, len1 - len2)
    else
      node2 = pad_list(node2, len2 - len1)
    end
    sum = add_lists_helper(node1, node2)
    sum.carry == 0 ? sum.sum : insert_before(sum.sum, sum.carry)
  end

  DualNode = Struct.new(:value, :prev, :next)

  private

  PartialSum = Struct.new(:sum, :carry)

  def self.length(node)
    return 0 if node.nil?
    count = 0
    head = node
    until head.nil?
      count += 1
      head = head.next
    end
    count
  end

  def self.add_lists_helper(node1, node2)
    return PartialSum.new(nil, 0) if node1.nil? && node2.nil?
    sum = add_lists_helper(node1.next, node2.next)
    val = sum.carry + node1.value + node2.value
    car, v = val.divmod(10)
    result = insert_before(sum.sum, v)
    sum.sum = result
    sum.carry = car
    sum
  end

  def self.pad_list(node, pad_length)
    head = node
    pad_length.times do
      n = DualNode.new(0, nil, nil)
      head.prev = n
      n.next = head
      head = n
    end
    head
  end

  def self.insert_before(node, value)
    n = DualNode.new(0, nil, nil)
    unless node.nil?
      node.prev = n
      n.next = node
    end
    n
  end

  public

  # Given a circular linked list, implement an algorithm
  # which returns the node at the beginning of the loop.
  def self.find_beginning_of_loop(node)
    slow = node
    fast = node

    # Find the meeting point, This will be LOOP_SIZE - k
    # steps into the linked list
    until fast.nil? or fast.next.nil?
      slow = slow.next
      fast = fast.next.next
      break if slow == fast
    end

    # Error checking in case that there is no loop at all
    return nil if fast.nil? or fast.next.nil?

    # Move slow to Head, keep fast at the meeting point.
    # Each are k steps from the Loop Start. If they move
    # at the same pace, they must meet at Loop Start.
    slow = node
    until slow == fast
      slow = slow.next
      fast = fast.next
    end

    # Now both of them point to the start of loop
    fast
  end

  # Implement a function to check if a linked list is a palindrome.
  # two possible solutions are:
  # 1. reverse the linked list then compare, note that we
  # only need to compare half of the list here.
  #
  # 2. hold the first half of list with a stack, then compare
  # the elements in stack and left in the list
  #
  # Below algorithm use the 2nd solution
  def self.palindrome?(node)
    return true if node.nil?
    first_half = []
    slow = node
    fast = node
    until fast.nil? or fast.next.nil?
      first_half.push(slow)
      fast = fast.next.next
      slow = slow.next
    end

    # if the linked list contains odd number of elements,
    # then fast should be nil, in contrary, if it contains
    # even number of elements, fast.next should be nil
    unless fast.nil?
      # skip the middle element
      slow = slow.next
    end

    # compare elements in stack and those still in linked list,
    # leveraging the slow flag.
    until slow.nil?
      return false if first_half.pop.value != slow.value
      slow = slow.next
    end
    true
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
