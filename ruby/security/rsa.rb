require 'prime'
require 'yaml'

def modpow(base, exponent, modulus)
  result = 1
  while exponent > 0
    result   = (base * result) % modulus unless (exponent & 1).zero?
    base     = (base * base)   % modulus
    exponent >>= 1
  end
  result
end



class Server
  attr_reader :raw_value_for_crypt
  def initialize
    @p = 503
    @q = 5507
    @n = @p * @q
    @n_dash = (@p-1)*(@q-1)
    #dが秘密鍵.あとでべき乗に使うので小さい方にしないと
    @d, @e = get_ed(@n_dash).sort

    puts "e=#{@e}"
    puts "d=#{@d}"
    #@d= 23;@e= 15316
    #暗号化したい数値をセット(条件があるのでこのようにいれることにしました
    #桁落ちしてた(本来はn-1以下なら問題ない)
    rand_limit = @n > 500 ? 500 : @n

    @raw_value_for_crypt = Random.rand(1..(rand_limit-1))
    puts "server send raw value is #{@raw_value_for_crypt}"
  end
  #n,eが公開鍵
  def send_pub
    return {n:@n, e:@e}
  end

  def send_cipher_text
    puts "sv send raw value=#{@raw_value_for_crypt}"
    #dが秘密鍵
    #@cripted = (@raw_value_for_crypt**@d) % @n
    @cripted = modpow(@raw_value_for_crypt, @d, @n)

    #temp = (@raw_value_for_crypt**@d)
    #temp2 = temp % @n
    #puts "sv cipher assert: #{@raw_value_for_crypt}**#{@d}= #{temp}"
    #puts "sv cipher assert: (#{temp}) % #{@n} = #{temp2}"
    puts "sv send cipher value=#{@cripted}"
    return @cripted
  end

  def assert_ed
    return ((@e * @d) ) % @n_dash == 1 ? true : false
  end
  private
  def get_ed(n_dash)
    #1= (e * d) % n_dash
    # -> (( e_d +1) % n_dash ) = 0
    # ->-> e_d_plus_1 = n_dash * x
    #n_dashで割りきれる数
    random = Random.rand(2..10)
    #random = 9
    hoge = (n_dash * random)
    #割りきれる数に+1
    e_d = hoge + 1
    puts "e_d value=#{e_d}"
    e,d = divide_ed(e_d)
    return e,d
  end
  def divide_ed(e_d)
    e = Prime.prime_division(e_d).sample.first
    d = e_d / e
    puts "d = e_d / e"
    puts "#{d} = #{e_d} / #{e}"
    return e, d
  end
end

class Client
  attr_reader :decoded
  def initialize
  end
  def recieve_pub(hash)
    @n = hash[:n]
    @e = hash[:e]
  end
  def recieve_cipher_text(cipher_text)
    puts "cl recieve cipher value=#{cipher_text}"
    @cipher_text = cipher_text
  end
  def decode_cipher
    #@decoded = (@cipher_text ** @e) % @n
    @decoded = modpow(@cipher_text, @e, @n)
    puts "cl decoded cipher =#{@decoded}"
  end
end

sv = Server.new
puts sv.assert_ed
cl = Client.new
cl.recieve_pub(sv.send_pub)
cl.recieve_cipher_text(sv.send_cipher_text)
cl.decode_cipher

result = sv.raw_value_for_crypt == cl.decoded ? 'success!!!!!!!!!!' : 'fail!!!!!!!!!!!!!!!!!'
puts result
puts '--------'
puts sv.to_yaml
puts '--------'
puts cl.to_yaml
#rsaを使った鍵交換では中間者攻撃しようとしても中間者が作った公開鍵に署名を付与できないので改竄ができない


