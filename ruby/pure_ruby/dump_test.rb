class Hoge
  attr_accessor :name
  def initialize
    @name = 'hoge'
  end
end


#h = Hoge.new
#c_name = h.name
#
##破壊的メソッドを使うと書き換わる
#h.name.replace('piyo')
#puts c_name
#
#
#
#h2 = Hoge.new
#c_name2 = h2.name.dup
#
##これは大丈夫
#h2.name.replace('piyo')
#puts c_name2





h =Hoge.new
h2 =h
h3 =h.dup
puts h.object_id
puts h2.object_id
puts h3.object_id

puts h.name.object_id
puts h2.name.object_id
puts h3.name.object_id
