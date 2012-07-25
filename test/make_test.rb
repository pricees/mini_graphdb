if ARGV[0].nil?
  puts "SYNTAX:\t ruby test/make_test.rb CLASS_NAME"
  exit
end
str = (<<'EOL').gsub('CLASS', ARGV[0])
require File.join('.', File.dirname(__FILE__), 'test_helper')

class CLASSTest

  describe CLASS do

    before do
    # TODO: Before hook
    end

    it "asserts true" do
      assert true
    end

  end
end
EOL

puts str
