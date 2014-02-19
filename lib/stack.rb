
require_relative 'min_max.rb'

module Ch3
  class Stack
    def initialize
      @stack = []
    end

    def pop
      raise StandardError if empty?
      @stack.pop
    end

    def push(e)
      @stack.push(e)
      @stack
    end

    def peek
      @stack[-1]
    end

    def empty?
      @stack.empty?
    end

    def size
      @stack.size
    end
  end

  class ThreeStacks
    def initialize
      @s = []
      @index0 = 0
      @index1 = 1
      @index2 = 2
    end

    def push(e, i)
      check_index(i)
      @s[eval("@index#{i}", get_binding)] = e
      #@s.send(:[]=, eval("@index#{i}", get_binding), e)
      eval("@index#{i} += 3", get_binding)
      self
    end

    def pop(i)
      check_index(i)
      #result = @s.send(:delete_at, eval("@index#{i}", get_binding))
      eval("@index#{i} -= 3", get_binding)
      eval("throw StandardError if @index#{i} < 0", get_binding)
      @s[(eval("@index#{i}", get_binding))]
    end

    def peek(i)
      check_index(i)
      @s[eval("@index#{i}", get_binding)]
    end

    def empty?
      @s.empty?
    end

    private
    def get_binding
      binding
    end

    def check_index(i)
      raise StandardError unless i <=2 and i >=0
    end
  end

  # How you would design a stack which, in addition to push and pop, also has
  # a function min which returns the min element? Push, pop and min should all
  # operate in O(1) time.
  class MinStack < Stack

    def initialize
      super
      @min_stack = Stack.new
    end

    def push(e)
      @min_stack.push(e) if ((e <=> min) < 0)
      super
    end

    def pop
      result = super
      @min_stack.pop if ((result <=> min) == 0)
      result
    end

    def min
      unless @min_stack.empty?
        @min_stack.peek
      else
        Fixnum::MAX
      end
    end
  end

  # SetOfStacks should be composed of several stacks and should create a new stack
  # once the previous one exceeds capacity. SetOfStacks#push and SetOfStacks#pop
  # should behave identically to a single stack.
  class SetOfStacks
    def initialize(threshold = 100)
      @threshold = threshold
      @stacks = []
      @stacks << Stack.new
    end

    def push(e)
      if @stacks[-1].size < @threshold
        @stacks[-1].push(e)
      else
        s = Stack.new
        s.push(e)
        @stacks << s
      end
      self
    end

    def pop
      raise StandardError if empty?
      if @stacks[-1].empty?
        @stacks.pop
      end
      @stacks[-1].pop
    end

    def empty?
      @stacks[0].empty?
    end

    def peek
      @stacks[-1].peek
    end

    def pop_at(i)
      raise StandardError if i > @stacks.size
      @stacks[i].pop
    end
  end
end

