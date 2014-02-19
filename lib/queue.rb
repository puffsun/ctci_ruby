
module CTCI
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
  end
end
