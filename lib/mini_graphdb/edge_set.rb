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

      #  NOTE: I know this is a bad comment
      #
      #  Set#add? returns nil if already part of set
      #
      #  If a node is added with its current weight,
      #    the first part of the statement fails
      #  If the node is added successfully, the second part executes.
      #  If the old_wt isn't nil, a faithful attempt to delete the node
      #    from its previous weight array is made
      #
      (@weights[wt] ||= Set.new).add?(node) &&
        (old_wt.nil? || @weights[old_wt].delete(node))
      self
    end
    alias_method :<<, :add

    def byweight
      @weights.compact.inject(:+)
    end

    private
    def initialize
      @weights = []
    end
  end
end
