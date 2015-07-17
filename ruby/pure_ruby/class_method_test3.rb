module Module_a
  def method_a
    puts 'method_a'
    puts "namae = #{@name}"
  end
  def self.method_b
    puts 'method_b'
  end
  module Child_module
    def child_method
      puts 'child_method'
    end
  end
end


class Class_b
  include Module_a
  #include Module_a
  def initialize
    @name = 'namae'
  end
end


b = Class_b.new
b.method_a
#Class_b::Child_module.child_method
b.child_method
b.method_b

#Class_b.method_b
#Class_b.method_a
