
require_relative '../spec_helper'

describe Ch4::BreadthFirstPaths do

  describe "#new" do
    it {should be_an_instance_of Ch4::BreadthFirstPaths}
    it {should respond_to :path_to?}
    it {should respond_to :path_to}
    it {should respond_to :dist_to}
  end

  describe "graph path operations" do
    before do
      graph = Ch4::Graph.new(4)
      graph.add_edge(0, 1)
      graph.add_edge(0, 3)
      graph.add_edge(1, 2)
      graph.add_edge(2, 3)
      @bfs = Ch4::BreadthFirstPaths.new(graph, 0)
    end

    it "should have path" do
      @bfs.path_to?(2).should == true
      @bfs.path_to?(3).should == true
      @bfs.path_to?(1).should == true
      @bfs.dist_to(1).should eql(1)
      @bfs.dist_to(2).should eql(2)
      @bfs.dist_to(3).should eql(1)

      @bfs.path_to(1).should eql([0, 1])
      @bfs.path_to(2).should eql([0, 1, 2])
      @bfs.path_to(3).should eql([0, 3])
    end

    it "should not have path" do
      @bfs.path_to?(4).should == nil
      @bfs.path_to(4).should == nil
    end
  end
end
