class Hoge
  def hello
    puts 'hello'
  end
end

hoge = Hoge.new
puts hoge.class
puts hoge.hello
metaclass = class << hoge; self; end
puts metaclass.class

foo = Class.new do
  def hello
    puts 'hello'
  end
end

Foo = foo

temp = Foo.new
puts temp.class
puts temp.hello
metaclass = class << temp; self; end
puts metaclass.class
