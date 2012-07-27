require File.join('.', File.dirname(__FILE__), 'test_helper')

class MiniGraphdbTest

  describe MiniGraphdb do

    it "creates a simple graph" do
      vertices = [
        [ 1, 3 ], [ 1, 2 ], [ 2, 11 ],
      ]

      graph = MiniGraphdb.simple_graph vertices

      vertices.each do |a_node, other_node|
        graph[a_node].edges.byweight.must_include graph[other_node]
      end
    end

    it "creates a complex graph with complimentary edges" do
      vertices = [ [ 1, 3, 99 ],  [ 1, 2, 66 ],  [ 2, 11, 363 ], ]

      graph = MiniGraphdb.complex_graph vertices

      vertices.each do |a_node, other_node, _|

        exp_wt = other_node * 33
        node   = graph[a_node]
        o_node = graph[other_node]

        node.outbound_edges.weight?(o_node).must_equal exp_wt
        o_node.inbound_edges.weight?(node).must_equal exp_wt
      end
    end

    it "creates a complex graph with in/out hash" do
      vertices = {
        :out => [ [ 1, 3, 9 ],  [ 1, 2, 6 ],  [ 2, 11, 33 ], ],
        :in  => [ [ 1, 3, 30 ], [ 3, 2, 20 ], [ 2, 1, 10 ], ]
      }

      graph = MiniGraphdb.complex_graph vertices

      vertices[:out].each do |a_node, other_node, _|
        tmp = graph[other_node]

        graph[a_node].edges[tmp].must_equal (other_node * 3)
      end

      vertices[:in].each do |a_node, other_node, _|
        tmp = graph[other_node]

        graph[a_node].inbound_edges[tmp].must_equal (other_node * 10)
      end
    end
  end
end
