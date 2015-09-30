class Hoge
  def hoge
    puts 'hoge'
  end
  #The class << self syntax changes the current self to point to the metaclass of the current object.
  class << self
    def meta_method
      puts 'meta_method'
    end
  end
end

hoge = Hoge.new

#Ruby provides a syntax for accessing an object's metaclass directly. By doing class << Person
#=無名クラス、Singletonクラス
class << hoge
  def fuga
    puts 'fuga'
  end
end

#Hogeにはメソッドがない
metaclass = class << Hoge; self; end
puts metaclass.instance_methods.grep(/fuga/)
#classメソッドはmetaクラスのインスタンスメソッド?
puts metaclass.instance_methods.grep(/meta/)
#hogeはclassクラスのインスタンスメソッド?
puts Hoge.instance_methods.grep(/hoge/)


#hogeオブジェクトのmetaclassにある

metaclass = class << hoge; self; end
puts metaclass.instance_methods.grep(/fuga/)

# object in Ruby also has its own metaclass
piyo = Object.new
def piyo.piyo1
  "piyo1"
end

class << piyo
  def piyo2
    puts 'piyo2'
  end
end
metaclass = class << piyo; self; end
puts metaclass.instance_methods.grep(/piyo/)

#In Ruby, both 'metaclass' and 'singleton class' means the same
#https://rubymonk.com/learning/books/4-ruby-primer-ascent/chapters/39-ruby-s-object-model/lessons/131-singleton-methods-and-metaclasses
puts Hoge.instance_methods.grep(/hoge/)
