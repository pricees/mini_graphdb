# MiniGraphdb

Mini graph db is meant to be a small toy graph database to use for fun.  Maybe one day it will be a big boy.

## Installation

Add this line to your application's Gemfile:

    gem 'mini_graphdb'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mini_graphdb

## Usage

Create a "simple graph" using an array of vertices

    v = [ [ 1, 3 ], [ 1, 2 ], [ 2, 11 ], ]
    graph = MiniGraphdb.simple_graph(v)

   (1) <-> (3)
    |
   (2) <-> (11)

Create a "complex graph" specifying in/out bound edges, weights, etc.

Create a node (subclassed from OpenStruct)

    n = MiniGraphdb::Node.new(type: :person, city: "Chi")
    n.name = "Fwank"

Create another node, connect with an edge, giving no weight

    v = MiniGraphdb::Node.new(type: :category, name: "Favorite Vacation Spots")

    n.outbound_edges << v
    v.inbound_edges  << n

Create a few other nodes, add to the outbound edges with a weight

    vs = MiniGraphdb::Node.new(type: :city, name: "Waikiki")
    v.edges.add(vs, 45)

    vs = MiniGraphdb::Node.new(type: :city, name: "Dubrovnik")
    v.edges.add(vs, 90)

    vs = MiniGraphdb::Node.new(type: :city, name: "Geneva")
    v.edges.add(vs, 15)

    v.edges.byweight

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
