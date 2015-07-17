# -*- encoding: utf-8 -*-
require 'date'
require 'launchy'

#Signal.trap("TSTP") do
#    # ctrl+z
#    # handle the signal
#  puts 'here!!!success'
#  abort
#end


#now = Time.now
#limit_time = now +  ( 1 * 48 * 60)

rest_minute = 48
rest_second = (rest_minute * 60)
duration = 3

  while rest_second > 0 do
    sleep duration
    rest_second = rest_second - duration
    puts "残り#{((rest_second)/60).truncate}分"
  end
  Launchy.open("/home/ogura/pictures/ebt04.png")


#48.downto(0) do |i|
#  puts "#{i} "+"|"*i
#  sleep 1
#end;
#puts '終了'
