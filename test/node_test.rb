require File.join('.', File.dirname(__FILE__), 'test_helper')

class NodeTest

  describe MiniGraphdb::Node do

    before do
    end

    it "asserts true" do
      assert true
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
  end
end
