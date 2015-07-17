require 'object_tree'
module A
  def self.method_a
    puts 'a'
  end
  def method_b
    puts 'b'
  end
end
class B
  include A
  def test
    A.method_a
    self.method_b
  end
  def self.test2
    A.method_a
    self.method_b
  end




end
b = B.new
B.test2

