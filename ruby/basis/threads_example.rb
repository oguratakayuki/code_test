list = ["A", "B", "C", "D"]
io   = File.open("result.log", "w")
threads = []

list.each do |name|
  threads << Thread.fork(name) do |name|
    for count in 10.times
      io.puts name
      sleep 1
    end
    puts "Thread#{name} completed!";
  end
end

threads.each do |thread|
  thread.join
end
#ps auxww -L | grep -e threads_example -e PID
#http://d.hatena.ne.jp/rx7/20101219/p1
