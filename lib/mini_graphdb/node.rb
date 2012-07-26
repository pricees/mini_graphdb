module MiniGraphdb
  class Node < OpenStruct

    def == (other_node)
      object_id == other_node.object_id
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

    def attributes
      instance_variable_get(:@table).dup
    end
  end
end
