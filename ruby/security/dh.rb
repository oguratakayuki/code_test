# -*- encoding: utf-8 -*-

class Host
  attr_reader :pub, :key
  def initialize(name, p, g)
    @p = p
    @g = g
    @name = name
    #scecretが共通鍵(公開されない)
    @scecret = (2..(@p-2)).to_a.sample
    puts "#{@name}のXは#{@scecret}に決まりました"
    #**でべき剰(^)
    #%で剰余
    #pubは公開情報
    @pub = (@g ** @scecret) % @p
    puts "#{@name}のYは#{@pub}に決まりました"
  end
  def recieve_pub(yb)
    @recieved_pub = yb
  end
  def generate_key
    #Diffie-Hellman鍵交換では、離散対数問題を利用して、秘密鍵そのものではなく、乱数と秘密鍵から生成した公開情報を送受信する
    @key ||= (@recieved_pub ** @scecret) % @p
    puts "#{@name}のkeyは#{@key}"
  end
end
class Middle
  attr_reader :pub, :key
  def initialize(name, p, g)
    @p = p
    @g = g
    @name = name
    #Xaが共通鍵(公開されない)
    @scecret = (2..(@p-2)).to_a.sample
    puts "#{@name}のXは#{@scecret}に決まりました"
    @pub = (@g ** @scecret) % @p
    puts "#{@name}のYは#{@pub}に決まりました"
    @recieved_pub = {}
  end
  def recieve_pub(name, pub)
    @recieved_pub[name] = pub
  end
  def pub_by_name(name)
    @recieved_pub[name]
  end
  def generate_key_by_name(name)
    #Diffie-Hellman鍵交換では、離散対数問題を利用して、秘密鍵そのものではなく、乱数と秘密鍵から生成した公開情報を送受信する
    key = (pub_by_name(name) ** @scecret) % @p
    puts "#{@name}の#{name}に対するkeyは#{key}"
  end
end
p = 19289
g = 5002
#p,g,pub_keyは公開される
#a = Host.new('A', p, g)
#b = Host.new('B', p, g)

#b.recieve_pub(a.pub)
#a.recieve_pub(b.pub)
#a.generate_key
#b.generate_key
#puts a.key
#puts b.key

a = Host.new('A', p, g)
b = Host.new('B', p, g)
m = Middle.new('M', p, g)

#a <-> m <-> b
m.recieve_pub(:a, a.pub)
a.recieve_pub(m.pub)

b.recieve_pub(m.pub)
m.recieve_pub(:b, b.pub)


puts a.generate_key
puts b.generate_key
puts m.generate_key_by_name(:a)
puts m.generate_key_by_name(:b)

#これでできた鍵でdes暗号の鍵やsslのプリマスタキーにしたりするのだろうか


#通信内容を第三者に盗聴されても、直ちに秘密鍵を知られることはなく、安全に鍵情報を交換することができる。ただし、送信者と受信者の通信に割り込んで、公開情報を自分のものとすりかえて暗号の解読を試みる「中間者攻撃」に対しては弱いことが知られている

