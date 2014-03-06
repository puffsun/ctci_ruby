
require_relative '../spec_helper'

describe Ch4::DepthFirstPaths do

  describe "#new" do
    it {should be_an_instance_of Ch4::DepthFirstPaths}
    it {should respond_to :path_to?}
    it {should respond_to :path_to}
  end

  describe "Depth First Paths" do
    before do
      graph = Ch4::Graph.new(4)
      graph.add_edge(0, 1)
      graph.add_edge(0, 3)
      graph.add_edge(1, 2)
      graph.add_edge(2, 3)
      @dfs = Ch4::DepthFirstPaths.new(graph, 0)
    end

    it "should have path" do
      @dfs.path_to?(1).should be_true
      @dfs.path_to?(2).should be_true
      @dfs.path_to?(3).should be_true

      @dfs.path_to(1).should eql([0, 1])
      @dfs.path_to(2).include?(0).should be_true
    end

    it "should not have path" do
      @dfs.path_to?(4).should be_false
      @dfs.path_to(4).should be_nil
    end
  end
end
