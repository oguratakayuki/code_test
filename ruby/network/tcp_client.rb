## -*- coding: utf-8 -*-
require 'socket'
require 'timeout'
# localhost の 10001 番ポートへ接続
s = TCPSocket.open("192.168.12.57", 10004)
# データ送信
10.times.each do |i|
  s.puts("Hello!")
  puts "Send : #{Time.now}"
  # サーバから戻ってきたデータを出力(1行のみ)
  begin
    timeout(5) do
      ret = s.gets.chomp
      if ret == 'OK'
        puts ret
      else
        puts ret
        puts 'server is sleep'
      end
    end
  rescue Timeout::Error
    puts "Timed out!"
  end
  puts "Receive : #{Time.now}"
  sleep 3
end
# 接続を閉じ
s.close
