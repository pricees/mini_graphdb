require "mini_graphdb/version"
require "ostruct"
require "set"

module MiniGraphdb
  extend self

  #
  #  == Simple Graph ==
  #  Pass an array of arrays containing couplets of node values
  #  Returns a hash of nodes, with reciprical zero weighted connections
  #
  # <tt>vertices</tt>  [ [a_node_val, other_node_val] ]
  #
  #
  def simple_graph(vertices, klass = MiniGraphdb::Node)
    nodes = Hash.new { |hsh, k| hsh[k] = klass.new(val: k) }

    vertices.each do |a_node, other_node|
      nodes[a_node].r_edge nodes[other_node]
    end

    def nodes.print_graph
      values.each do |node|
        edges = node.edges.byweight.map(&:val).join(", ")
        puts "#{node.val} => #{edges}"
      end
    end

    nodes
  end

  #
  #  == Complex Graph ==
  #  Pass an array of arrays containing couplets of node values
  #  Returns a hash of nodes, with reciprical zero weighted connections
  #
  # <tt>vertices</tt>  {
  #   :out  => [
  #     [a_node_val, other_node_val, weight],
  #   ],
  #   :in => [
  #     [a_node_val, other_node_val, weight],
  #   ]
  # }
  #
  #

  def complex_graph(vertices, klass = MiniGraphdb::Node)
    nodes = Hash.new { |hsh, k| hsh[k] = klass.new(val: k) }

    case vertices
    when Hash
      add_edges(nodes, vertices[:out], :outbound)
      add_edges(nodes, vertices[:in],  :inbound)
    when Array
      vertices && vertices.each do |a_node, other_node, wt|
        nodes[a_node].c_edge(nodes[other_node], wt.to_i)
      end
    else
      raise "Vertices, #{vertices.class}, must be Hash or Array"
    end

    add_print_method(nodes)

    nodes
  end

  private
  #
  #  == Add Edges ==
  #  ::nodes <tt>hash of nodes</tt>
  #  ::ary   <tt>array of arrays: src_node, dst_node, wt</tt>
  #  ::edge_type <tt>:inbound_edges, :outbound_edges</tt>
  #
  def add_edges(nodes, ary, edge_type)

    ary && ary.each do |a_node, other_node, wt|
      nodes[a_node].
        send(edge_type).
        add(nodes[other_node], wt.to_i)
    end

    nodes
  end

  def add_print_method(nodes)
    def nodes.print_graph
      values.each do |node|
        [ :inbound, :outbound ].each do |edge_type|
          edges = node.send(edge_type).byweight.map(&:val).join(", ")
          puts "#{edge_type}:\t#{node.val} => #{edges}"
        end
      end
    end
    nodes
  end


end

require 'mini_graphdb/node'
require 'mini_graphdb/edge_set'
