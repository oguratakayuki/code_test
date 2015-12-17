# -*- encoding: utf-8 -*-
#moduleのselfメソッドはモジュールメソッドと呼ばれる

#instanceメソッドはinstanceからしか呼べず、classメソッドはclassからしかよべない
#class include module の場合はmoduleのselfがついてないメソッドをinstanceメソッドとして取り込む
#class extend module の場合はself.のついていないメソッドをクラスメソッドとして取り込む(L.109, L.40)
#
#
#現状、module内でself.で定義されたmethodをrubyの範囲で取り込む手段がわからない
#module内でself付きで定義されたメソッドはHoge.fugaと直接呼ぶために実装されるのが基本か
#include,extendともにselfがついていないメソッドをとりこむ
# includeはそれらのメソッドをinstanceメソッドとして、extendはクラスメソッドとして取り込む
#
# module -> moduleに関しては
# extendしたときのみ Hoge.fuga (モジュール)として呼べる
module A
  def self.method_a
    puts 'method_a'
  end
  def method_a2
    puts 'method_a2'
  end
end
#直接呼び出す
A.method_a
#A.method_a2 #呼べない Rubyではモジュールをインクルードしても、モジュールのインスタンスメソッドはクラスには継承されません.呼ぶにはextendする

# includeした場合
module B
  include A
  def self.method_b
    puts 'method_b'
  end
end

B.method_b
#B.method_a  #include,extendどちらでもよべない
#B.method_a2 #includeでは呼べないがextendでならよべる

## extendした場合
module B2
  extend A
  def self.method_b
    puts 'method_b'
  end
end

#B2.method_a  #よべない(
B2.method_a2 #includeではなくてextendなのでよべる!!!但しクラスメソッドになる
             #Rubyではモジュールをインクルードしても、モジュールメソッド（モジュールの特異メソッド）はクラスには継承されません

#extendをincludeでやった場合
#ModuleもClassクラスのインスタンスなため、無名クラスをオープンしてその特異クラスを定義しそこでinclude
#無名クラスを定義して、そこでAをinclude?
class << B
  include A
end
B.method_a2

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
  def self.method_f
    puts 'method_f'
  end
  def method_f2
    puts 'method_f2'
  end
end

F.method_f
#F.method_f2 #インスタンスメソッドなのでよべない


#!!!!!!!!!!!!!!!!!!!!!!!!!!
#F.method_d #モジュールのselfメソッドがMix-in先クラスのselfメソッドとして働くことはありません。
            #つまりモジュールメソッドはクラスメソッドにはならないのです。この点が継承の場合とは異なっています。
F.method_d2 #extendはモジュールのメソッドを直接オブジェクトに追加できる(その際クラスメソッドになる？)
#!!!!!!!!!!!!!!!!!!!!!!!!!!



f_obj = F.new
#インスタンス化することでclassオブジェクトでもなくmoduleオブジェクトでもなくオブジェクトになる
#オブジェクトはクラスやモジュールと同様に、その内部にselfメソッドを持つことができます。
#オブジェクトにおけるselfメソッドは、「Singletonメソッド」または「抽象メソッド」などと呼ばれています。
#f_obj.method_d #呼べない!
#f_obj.method_d2 #呼べない.!!!Dモジュールがmixinされたのはf_objectではなく、Fクラス.f_objectはオブジェクトで、Fクラスではない

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

