
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

  class AnimalQueue
    def initialize
      @dogs = []
      @cats = []
    end

    def enq(a)
      raise ArgumentError unless a
      if a.instance_of? Cat
        @cats << a
      elsif a.instance_of? Dog
        @dogs << a
      else
        raise StandardError, "Unsupported animal type."
      end
      self
    end

    def deq_cat
      @cats.shift
    end

    def deq_dog
      @dogs.shift
    end

    def deq_any
      return @dogs.shift if @cats.empty?
      return @cats.shift if @dogs.empty?
      @dogs[0].found < @cats[0].found ? @dogs.shift : @cats.shift
    end

    def empty?
      @dogs.empty? && @cats.empty?
    end
  end

  class Animal
    attr_reader :found
    attr_accessor :name

    def initialize(name)
      @name = name
      @found = Time.now
    end
  end

  class Cat < Animal
  end

  class Dog < Animal
  end
end
