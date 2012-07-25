require File.join('.', File.dirname(__FILE__), 'test_helper')

class EdgeSetTest

  describe MiniGraphdb::EdgeSet do

    before do
      @e = MiniGraphdb::EdgeSet.new
    end

    it "is a hash of arrays" do

      @e.key?(:foo).must_equal false

      assert @e[:foo].is_a?(Array)
      @e[:foo].must_be_empty

    end

    it "adds node without weighted edge" do
      assert @e.empty?

      node = MiniGraphdb::Node.new(type: :widget)

      @e << node

      @e.must_include node
      @e.weight?(node).must_equal 0
      @e.weights[0].must_equal [node]
    end

    it "adds node without weighted edge" do
      assert @e.empty?

      node = MiniGraphdb::Node.new(type: :widget)

      @e.add(node, 10)

      @e.must_include node
      @e.weight?(node).must_equal 10
      @e.weights[10].must_equal [node]
    end

    it "adds multiple nodes" do

      nodes = 4.times.map do |n|
        MiniGraphdb::Node.new(type: "widget_#{n}")
      end

      @e << nodes[1]

      @e.add(nodes[0], 15)
      @e.add(nodes[3], 100)
      @e.add(nodes[2], 100)

      @e.weight?(nodes[1]).must_equal 0
      @e.weight?(nodes[0]).must_equal 15

      @e.weights[100].must_equal [nodes[3], nodes[2]]
      @e.weights[0].must_equal   [nodes[1]]
    end

    it "sorts_by_weight" do

      nodes = 4.times.map do |n|
        MiniGraphdb::Node.new(type: "widget_#{n}")
      end

      @e.must_be_empty

      @e.add(nodes[2], 0)
      @e.add(nodes[1], 15)
      @e.add(nodes[0], 100)
      @e.add(nodes[3], 100)

      @e.byweight.must_equal nodes.values_at(2, 1, 0, 3)
    end
  end
end
