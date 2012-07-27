module MiniGraphdb
  class Node < OpenStruct

    def id
      attributes.hash
    end

    def == (other_node)
      id == other_node.id
    end

    def inbound_edges
      @inbound_edges ||= EdgeSet.new
    end
    alias_method :inbound, :inbound_edges

    def outbound_edges
      @outbound_edges ||= EdgeSet.new
    end
    alias_method :outbound, :outbound_edges
    alias_method :edges,    :outbound_edges

    #
    #  Reciprical edge:
    #    Zero weight outbound edge from self -> other_node
    #    Zero weight outbound edge from other_node -> self
    #
    def r_edge(other_node)
      (self.edges << other_node) && (other_node.edges << self)
      self
    end

    #
    #  Complimentary edge:
    #    Weighted outbound edge from self -> other_node
    #    Weighted inbound  edge from other_node -> self
    #
    def c_edge(other_node, wt = 0)
      (self.outbound_edges.add(other_node, wt) &&
       other_node.inbound_edges.add(self, wt))
      self
    end

    def attributes
      instance_variable_get(:@table).dup
    end
  end
end
