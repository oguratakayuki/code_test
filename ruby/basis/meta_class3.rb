class Object
  def metaclass
    class << self
      self
    end
  end
end

class Bar
  def method_1
    puts 'hello'
  end
  def self.method_2
  end
  class << self
    def method_3
    end
  end
end
class_i = Class.new
bar_i = Bar.new
puts "diff in methods"
(bar_i.methods - class_i.methods).each do |method|
  puts method
end
puts "diff in meta methods"
(bar_i.metaclass.methods - class_i.metaclass.methods).each do |method|
  puts method
end
puts "end"

puts Bar.instance_methods.grep(/method_1/)
puts Bar.metaclass.instance_methods.grep(/method_2/)
puts Bar.metaclass.instance_methods.grep(/method_3/)

