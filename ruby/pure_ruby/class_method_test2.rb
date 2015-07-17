# -*- encoding: utf-8 -*-
module D
  def self.method_d
    puts 'method_d'
  end
  def method_d2 #特異メソッド。このmoduleをincludeしたインスタンスからしか呼ぶことができないためそう呼ばれる?
    puts 'method_d2'
  end
end

class E
  include D
end

D.method_d
#D.method_d2 #呼べない!!!


#E.method_d  # #!!!!includeで追加されるのはインスタンスメソッドのみ!!!
#E.method_d2  # #!!!!Eがinstanceではないので呼べない
e_obj = E.new
#e_obj.method_c2
#e_obj.method_d
#e_obj.method_d #!!!!includeで追加されるのはインスタンスメソッドのみ!!!
e_obj.method_d2 #e_objがinstanceでincludeしたDのmethod_2がインスタンスメソッドなので呼べる

class F
  extend D
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

