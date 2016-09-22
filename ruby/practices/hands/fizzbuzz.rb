puts (1..30).to_a.map{|t| out= ''; out = 'fizz' if  t % 3 == 0; out = out + 'buzz' if t % 5 == 0; (out.length > 0 && out) || t}

