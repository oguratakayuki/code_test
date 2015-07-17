# -*- encoding: utf-8 -*-

ret = `mysql -uroot -prootp nightstyle_development -e'show tables;'`
puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
ret.each_line do |line|
  puts line.chomp
end

