
require 'queue'
require 'min_max'

module Ch4
  class Graph

    attr_reader :vertexes, :edges

    def initialize(v = 100)
      @vertexes = v
      @edges = 0
      @adjacents = []
      0.upto(v) {|i| @adjacents[i] = []}
    end

    def add_edge(v, e)
      check_index(v)
      check_index(e)

      @adjacents[v] << e
      @adjacents[e] << v

      @edges += 1
    end

    def adj(v)
      check_index(v)
      @adjacents[v]
    end

    private

    def check_index(v)
      raise ArgumentError if v < 0 || v > @vertexes
    end
  end

  class BreadthFirstPaths

    def initialize(graph = Graph.new, src = 0)
      @src = src
      # previous edge on the shorted path
      @edge_to = []
      # number of edges of shorted path from source to destination
      @dist_to = []
      # is there a path from source to destination?
      @marked = []
      bfs(graph, src)
    end

    def path_to(v)
      return nil unless path_to?(v)
      path = []
      last_vertex = @edge_to[v]
      path << @src
      until @dist_to[last_vertex] == 0
        path << last_vertex
        last_vertex = @edge_to[last_vertex]
      end
      path << v
    end

    def dist_to(v)
      @dist_to[v]
    end

    def path_to?(v)
      @marked[v]
    end

    private

    def bfs(graph, src)
      q = Ch3::Queue.new
      0.upto(graph.vertexes) do |v|
        # -1 means no path to the destination
        @dist_to[v] = -1
      end
      @dist_to[src] = 0
      @marked[src] = true
      q.enq(src)

      until q.empty? do
        v = q.deq
        graph.adj(v).each do |e|
          unless @marked[e]
            @edge_to[e] = v
            @dist_to[e] = @dist_to[v] + 1
            @marked[e] = true
            q.enq(e)
          end
        end
      end
    end
  end

  class DepthFirstPaths

    def initialize(graph = Graph.new, src = 0)
      @src = src
      @marked = []
      @edge_to = []
      dfs(graph, src)
    end

    def path_to?(dst)
      @marked[dst]
    end

    def path_to(dst)
      return nil unless path_to?(dst)
      path = []
      last_vertex = @edge_to[dst]
      path << @src
      until last_vertex == @src
        path << last_vertex
        last_vertex = @edge_to[last_vertex]
      end
      path << dst
    end

    private

    def dfs(graph, src)
      @marked[src] = true
      graph.adj(src).each do |v|
        unless @marked[v]
          @edge_to[v] = src
          dfs(graph, v)
        end
      end
    end
  end
end
