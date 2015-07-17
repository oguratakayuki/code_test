# -*- encoding: utf-8 -*-

#instanceメソッドはinstanceからしかよべず、classメソッドはclassからしかよべない
#class include module の場合はinstanceメソッドとして取り込む
#class extend module の場合はクラスメソッドとして取り込む
module A
  def self.method_a
    puts 'method_a'
  end
  def method_a2
    puts 'method_a2'
  end
end

# includeした場合
module B
  include A
  def self.method_b
    puts 'method_b'
  end
end


A.method_a
#A.method_a2 #呼べない Rubyではモジュールをインクルードしても、モジュールメソッド（モジュールの特異メソッド）はクラスには継承されません.呼ぶにはextendする
B.method_b
#B.method_a  include ではインスタンスメソッドのみ追加される


## extendした場合
module B2
  extend A
  def self.method_b
    puts 'method_b'
  end
end

#B2.method_a  #よべない(
B2.method_a2 #includeではなくてextendなのでよべる!!!
             #Rubyではモジュールをインクルードしても、モジュールメソッド（モジュールの特異メソッド）はクラスには継承されません



class C
  def self.method_c
    puts 'method_c'
  end
  def method_c2
    puts 'method_c2'
  end
end

module D
  #include C moduleはclassをincludeできない
  #extend C moduleはclassをextendできない
  def self.method_d
    puts 'method_d'
  end
  def method_d2 #特異メソッド。このmoduleをincludeしたインスタンスからしか呼ぶことができないためそう呼ばれる?
    puts 'method_d2'
  end
end

D.method_d
#D.method_c
#D.method_c2

class E
  #include C classはincludeできない
  #extend C classはextendできない
  include D
  def self.method_e
    puts 'method_e'
  end
  def method_e2
    puts 'method_e2'
  end
end

E.method_e
#E.method_d  # #!!!!includeで追加されるのはインスタンスメソッドのみ!!!
#E.method_d2  # #!!!!Eがinstanceではないので呼べない
e_obj = E.new

#e_obj.method_d #!!!!includeで追加されるのはインスタンスメソッドのみ!!!
e_obj.method_d2 #e_objがinstanceでincludeしたDのmethod_2がインスタンスメソッドなので呼べる


class F
  #include C classはincludeできない
  #extend C classはextendできない
  extend D
  def self.method_e
    puts 'method_e'
  end
  def method_e2
    puts 'method_e2'
  end
end

#F.method_d
F.method_d2 #呼べる！なぜ？ #instance化していない

f_obj = F.new
#f_obj.method_d #呼べない!
#f_obj.method_d2 #呼べない!

f_obj2 = F.new
f_obj2.extend D
#f_obj2.method_d
f_obj2.method_d2 #呼べる(extendはレシーバーとなるオブジェクトの特異クラス(instance)に引数となる Module の機能をいれる)
#ということでextendでインスタンスメソッドを呼び出したい場合はinstance化したobjectでextendメソッドを呼び出さなければいけない
#これを実現するのがincluded!!!
#includedメソッドは、includeメソッドによってモジュールが他のモジュールやクラスにインクルードされたあとに呼び出されます。
#(引数にはモジュールをインクルードするクラスやモジュールが入ります。)
#このincludedメソッド内でextendすることでmoduleの特異メソッドを呼び出せる

class G
  include D
  def self.method_e
    puts 'method_e'
  end
  def method_e2
    puts 'method_e2'
  end
end




g_obj = G.new
g_obj.method_d
g_obj.method_d2

