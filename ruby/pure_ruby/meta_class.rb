class Hoge
  def hoge
    puts 'hoge'
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
