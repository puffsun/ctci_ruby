
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
