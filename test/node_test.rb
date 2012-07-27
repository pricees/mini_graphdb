require File.join('.', File.dirname(__FILE__), 'test_helper')

class NodeTest

  describe MiniGraphdb::Node do

    before do
    end

    it "is comparable" do
      n = MiniGraphdb::Node.new(name: :Ted, age: 32)
      m = MiniGraphdb::Node.new(n.attributes)

      n.must_equal m

      m.age = 33
      assert n != m
    end

    it "has hash of attributes" do
      n = MiniGraphdb::Node.new(name: :Ted, age: 32)
      n.city = "Chicago"

      attributes = n.attributes
      attributes[:name].must_equal :Ted
      attributes[:age].must_equal  32
      attributes[:city].must_equal "Chicago"

    end

    it "protects its attributes" do

      n = MiniGraphdb::Node.new(type: :person)
      n.type.must_equal :person
      n.attributes[:type].must_equal :person

      n.attributes[:type] = :animal

      n.type.must_equal :person
      n.attributes[:type].must_equal :person
    end

    describe "has edge sets" do

      before do
        @me = MiniGraphdb::Node.new(name: "Ted")
      end

      it "has outbound edges contecting nodes" do

        names = %w(Raleigh Ryan Jason)

        names.each_with_index do |name, wt|
          f = MiniGraphdb::Node.new(name: name)
          @me.outbound_edges.add(f, wt)
        end
      end


      it "has outbound edges contecting nodes" do

        names = %w(Raleigh Ryan Jason)

        names.each_with_index do |name, wt|
          f = MiniGraphdb::Node.new(name: name)
          @me.outbound_edges.add(f, wt)
        end

        assert_equal @me.outbound_edges, @me.outbound
        assert_equal @me.outbound_edges, @me.edges

        @me.outbound_edges.byweight.map(&:name).must_equal names
      end

      it "has outbound edges contecting nodes of the same weight" do

        names = %w(Raleigh Ryan Jason)

        names.each_with_index do |name, wt|
          f = MiniGraphdb::Node.new(name: name)
          @me.edges << f
        end

        @me.outbound_edges.byweight.map(&:name).must_equal names
      end

      it "has inbound edges contecting nodes" do

        names = %w(Erica Tiffany Jennifer)

        names.each_with_index do |name, wt|
          f = MiniGraphdb::Node.new(name: name)
          @me.inbound_edges.add(f, 2_000 - wt)
        end

        assert_equal @me.inbound_edges, @me.inbound

        @me.inbound_edges.byweight.map(&:name).must_equal names.reverse
      end

      it "just do what it do" do

        me  = MiniGraphdb::Node.new(name: "me")
        you = MiniGraphdb::Node.new(name: "you")
        mom = MiniGraphdb::Node.new(name: "your mom")

        # Outbound me -> you -> your mom
        me.edges  << you
        you.edges << mom
        mom.edges << me

        me.edges.must_include  you
        you.edges.must_include mom
        mom.edges.must_include me

        # Inbound you -> your mom -> me
        me.inbound_edges  << mom
        you.inbound_edges << me
        mom.inbound_edges << you

        me.inbound_edges.must_include  mom
        you.inbound_edges.must_include me
        mom.inbound_edges.must_include you
      end
    end

    it "creates recipricol edges" do

      m = MiniGraphdb::Node.new(name: :foo)
      assert m.edges.empty?

      %w(bar baz).each_with_index do |name, i|

        n = MiniGraphdb::Node.new(name: name)
        assert n.edges.empty?
        m.r_edge n
      end

      m.edges.byweight.map(&:name).sort.must_equal %w(bar baz)
    end

    it "creates complimentary edges" do

      m = MiniGraphdb::Node.new(name: :foo)

      nodes = { m.name => m }

      %w(bar baz).each do |name|
        nodes[name] = MiniGraphdb::Node.new(name: name)

        m.c_edge(nodes[name])
      end

      m.outbound_edges.byweight.map(&:name).sort.must_equal %w(bar baz)
      nodes["baz"].inbound_edges.byweight.must_equal Set[m]
      nodes["bar"].inbound_edges.byweight.must_equal Set[m]
    end

  end
end
