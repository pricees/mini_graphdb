require File.join('.', File.dirname(__FILE__), 'test_helper')

class NodeTest

  describe MiniGraphdb::Node do

    before do
    end

    it "is comparable" do
      n = MiniGraphdb::Node.new(name: :Ted, age: 32)
      m = MiniGraphdb::Node.new(name: :Ted, age: 32)

      assert n == m

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

        assert_equal @me.outbound_edges, @me.outbound
        assert_equal @me.outbound_edges, @me.edges

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
  end
end
