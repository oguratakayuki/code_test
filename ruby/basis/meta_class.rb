#In Ruby, both 'metaclass' and 'singleton class' means the same
#https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/39-ruby-s-object-model/lessons/131-singleton-methods-and-metaclasses

#Class < Module < Object < Kernel (< BasicObject)
class Object
  def metaclass
    class << self
      self
    end
  end
end

Hoge = Class.new do
  def hello
  end
end
metaclass = Hoge.metaclass
class Fuga
end

class Hoge
  def self.hello2
  end
end

puts Hoge.ancestors
puts '----'
puts Fuga.ancestors
