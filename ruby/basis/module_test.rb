# -*- encoding: utf-8 -*-

#module A
#  class B
#    def self.method_b
#      puts 'method_b:こちらの方がinitializeより先に実行される'
#    end
#    method_b
#    def initialize
#      puts 'initialize'
#    end
#  end
#end
#
#b = A::B.new
#

#moduleを静的に呼び出す場合はdef self.hogeとよびだす方法
#moduleをネームスペースとして利用する.中にclassがある場合でも有効
#module内に定義したインスタンスメソッドはclassからincludeしてとりこまないと有効にならない
#
module C
  class D
    def self.method_d
      puts 'method_d:こちらの方がinitializeより先に実行される(1回だけ)'
    end
    def initialize
      puts 'initialize D'
    end
    method_d
    class E
      def initialize
        puts 'initialize E'
      end
    end
  end
end

#e = C::D.new
e = C::D::E.new


module Phone
  class Mobile
    def initialize(name, number)
      @name = name
      @number = number
    end
    def type
      Phone::Tool.analayze_type(@number)
    end
  end
  class Stable
    def initialize(name, number)
      @name = name
      @number = number
    end
    def type
      Phone::Tool.analayze_type(@number)
    end
  end

  module Tool
    def self.analayze_type(number)
      if number == '090'
        'mobile'
      else
        'stable'
      end
    end
  end
end

mobile_phone = Phone::Mobile.new('old phone', '090')
puts mobile_phone.type

puts Phone::Tool.analayze_type('090')



