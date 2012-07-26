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
      #  If the node is added to its current weight, the statement fails
      #  If it sets, then either the old_wt is nil or it deletes the old node
      #  in its weight set
      #
      #  Technically if it successfully "adds", then old_wt shouldn't be nil
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
