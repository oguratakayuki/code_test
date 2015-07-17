# -*- encoding: utf-8 -*-


module C
  class D
    attr_accessor :var_e, :var_d
    def self.method_d
      puts 'method_d:こちらの方がinitializeより先に実行される'
      @var_d = 'ddd'
    end
    def initialize
      puts 'D class initialize'
    end
    method_d
    class E
      attr_accessor :var_e, :var_d
      def initialize
        puts 'E class initialize'
        @var_e = 'e'
        super
      end
    end
  end
end

e = C::D::E.new

puts e.var_d
puts e.var_e
