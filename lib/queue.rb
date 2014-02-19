
module Ch3
  class Queue

    def initialize
      @q = []
    end

    def enq(e)
      @q << e
      self
    end

    def deq
      raise StandardError if empty?
      @q.shift
    end

    def empty?
      @q.empty?
    end
  end

  # Queue implemented with two stacks
  class MyQueue
    def initialize
      @stack1 = Stack.new
      @stack2 = Stack.new
    end

    def enq(e)
      @stack1.push(e)
      self
    end

    def deq
      if @stack2.empty?
        while !@stack1.empty?
          @stack2.push(@stack1.pop)
        end
      end
      @stack2.pop
    end

    def empty?
      @stack1.empty? && @stack2.empty?
    end

    def size
      @stack1.size + @stack2.size
    end
  end
end
