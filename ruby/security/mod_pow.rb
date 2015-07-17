
#https://www.omniref.com/ruby/gems/rsa/0.1.2/symbols/RSA::Math/modpow/singleton#line=133
#@param  [Integer] exponent 指数
#@param  [Integer] modulus 率
#@return [Integer]
#@see    http://en.wikipedia.org/wiki/Modular_exponentiation
# c = bのe乗 / m
def modpow(base, exponent, modulus)
  result = 1
  while exponent > 0
    result   = (base * result) % modulus unless (exponent & 1).zero?
    base     = (base * base)   % modulus
    exponent >>= 1
  end
  result
end
#baseのe乗に対してmodulusで剰余をとるかわりに
#base一個一個にmoduusの剰余をとっても同じ
#((4 % 5) * (4%5) * (4%5)) %5 == 4**3 % 5
def modpow_wiki(base, exponent, modulus)
  result = 1
  while exponent > 0
    if (exponent & 1) != 0 #exponentの一番下のbitが1なら
      result   = (base * result) % modulus
    end
    base     = (base * base)   % modulus
    exponent >>= 1 #右に1bitシフトして代入(1/2になる)
  end
  result
end
#bitがたっているとき2回冪乗するそれぞれに剰余をとる
#bitがたっていないとき1回それに剰余をとる
#bitと冪乗する回数があうのはなぜか


puts modpow_wiki(4,13,497)
puts modpow(4,13,497)
