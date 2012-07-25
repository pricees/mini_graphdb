module MiniGraphdb
  class Node < OpenStruct

    def inbound_edges
      @inbound_edges ||= Edges.new
    end
    alias_method :inbound, :inbound_edges

    def outbound_edges
      @outbound_edges ||= Edges.new
    end
    alias_method :outbound, :outbound_edges
    alias_method :edges,    :outbound_edges

    def attributes
      instance_variable_get(:@table).dup
    end
  end
end
