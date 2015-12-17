class Hoge
  def hoge
    puts 'hoge'
  end
  #The class << self syntax changes the current self to point to the metaclass of the current object.
  class << self
    def method_a
      puts 'meta_method'
    end
  end
  def self.method_b
    puts 'method_b'
  end
end

metaclass = class << Hoge; self; end
puts metaclass.instance_methods.grep(/method_a/)
puts metaclass.instance_methods.grep(/method_b/)

