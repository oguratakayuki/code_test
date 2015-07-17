module M
  def self.method_m1
    puts 'method_m1'
  end
  def method_m2
    puts 'method_m2'
  end
  def self.included(base)
    base.class_eval do
      def method_m3
        puts 'method_m3'
      end
    end
  end
  def self.extended(base)
    base.class_eval do
      def method_m4
        puts 'method_m4'
      end
    end
  end
end

class B
  include M
end

class C
  extend M
end

#class include module の場合はinstanceメソッドとして取り込む
#class extend module の場合はクラスメソッドとして取り込む

#B.method_m1
#B.method_m2
#C.method_m1 #extendでとりこまれるのは特異メソッドのみ
C.method_m2 #extendでクラスメソッドとして取り込んでいる

b = B.new
c = C.new

#b.method_m1
b.method_m2 #includeでインスタンスメソッドとしてとりこむ(対象はmoduleの特異メソッド)
#c.method_m1
#c.method_m2

#取り込まれた先でも実行できるクラスメソッドを定義するにはincludedでclass_evalする

#B.method_m3
#B.method_m3
#C.method_m3
#C.method_m3
b.method_m3
#c.method_m3

#取り込まれた先でも実行できるクラスメソッドを定義するにはextendedでclass_evalする

#B.method_m4
#B.method_m4
#C.method_m4
#C.method_m4
#b.method_m4
c.method_m4

