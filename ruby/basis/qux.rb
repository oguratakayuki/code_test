# qux.rb
Qux = "I'm at the root!"

 # foo.rb
module Foo
end

 # foo/qux.rb
module Foo
  Qux = "I'm in Foo!"
end

# foo/bar.rb
class Foo::Bar
  def self.print_qux
    puts Qux
  end
end
Foo::Bar.print_qux
