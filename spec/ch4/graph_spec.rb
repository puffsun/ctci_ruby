
require_relative '../../lib/graph'

describe Ch4::Graph do
  let(:graph) {Ch4::Graph.new(3)}

  describe "#new" do
    it {should be_an_instance_of Ch4::Graph}
    it {should respond_to :vertexes}
    it {should respond_to :edges}
    it {should respond_to :add_edge}
    it {should respond_to :adj}
  end

  describe "perform Graph operations" do
    before do
      graph.add_edge(0, 1)
      graph.add_edge(0, 3)
      graph.add_edge(1, 2)
      graph.add_edge(1, 3)
    end

    it "should support normal graph operations" do
      graph.vertexes.should eql(3)
      graph.edges.should eql(4)
      graph.adj(0).sort.should eql([1, 3])
      graph.adj(1).sort.should eql([0, 2, 3])
      graph.adj(2).sort.should eql([1])
      graph.adj(3).sort.should eql([0, 1])
    end
  end
end
