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

#extend -> class method
C.method_m2 #extendでクラスメソッドとして取り込んでいる
b = B.new
# include -> instance method
b.method_m2 #includeでインスタンスメソッドとしてとりこむ(対象はmoduleの特異メソッド)



#取り込まれた先でも実行できるクラスメソッドを定義するにはincluded,extendedでclass_evalする
b.method_m3
c.method_m4

