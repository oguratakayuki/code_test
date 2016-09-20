def divisors_of num
  (1..num).to_a.reject{|t| num % t != 0 }
end

num = 12
puts divisors_of(num).reduce(&:+)
