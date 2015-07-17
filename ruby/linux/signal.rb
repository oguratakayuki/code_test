# Ctrl + C で停止させられた場合の処理を登録
while true
  sleep 1
  puts 'hello'
  Signal.trap(:INT) do
    puts ''
    puts "SIGINT(ctrl+d)"
    puts ''
    exit(0)
  end
  Signal.trap(:TSTP) do
    puts ''
    puts "SIGTSTOP"
    puts "SIGTSTOP(ctrl+z)"
    puts ''
    exit(0)
  end
end
