module MiniGraphdb
  class EdgeSet < Hash

    attr_reader :weights

    alias_method :weight?, :[]

    def add(node, wt = 0)
      (@weights[wt.to_i] ||= []) << node
      self[node] = wt.to_i
      self
    end
    alias_method :<<, :add

    def byweight
      @weights.flatten.compact
    end

    private
    def initialize
      super { |hsh, k| hsh[k] = [] }
      @weights = Array.new
    end
  end
end
