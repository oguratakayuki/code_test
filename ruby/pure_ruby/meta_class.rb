class Hoge
  def hoge
    puts 'hoge'
  end
end

hoge = Hoge.new

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
