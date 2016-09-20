def divisors_of num
  (1..num).to_a.reject{|t| num % t != 0 }
end

def is_prime? num
  divisors_of(num) == [1, num]
end

def prime_fuctorization num, primes=[]
  if is_prime? num
    return primes << num
  end
  divisor_and_prime = divisors_of(num).reject{|t| !is_prime?(t)}.first

  ret = num / divisor_and_prime
  primes << divisor_and_prime
  prime_fuctorization(ret, primes)
end

num = 34
puts prime_fuctorization(num).to_s

