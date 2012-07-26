module MiniGraphdb
  class EdgeSet < Hash

    attr_reader :weights

    alias_method :weight?, :[]

    #
    # Add weight
    #
    def add(node, wt = 0)
      old_wt = self[node]
      self[node] = wt

      (@weights[wt] ||= Set.new).add?(node)

      @weights[old_wt].delete(node) if old_wt
      self
    end
    alias_method :<<, :add

    def byweight
      @weights.compact.inject(:+)
    end

    private
    def initialize
      @weights = [] # Hash.new { |hsh, k| hsh[k] = [] }
    end
  end
end
