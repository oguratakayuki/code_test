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

