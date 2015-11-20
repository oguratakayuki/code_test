#threadとexceptionとrescueについて

threads = []
%w(a b c d e f g).each do |alphabet|
  begin
    threads << Thread.fork(alphabet) do |alp|
      begin
        puts "thread for #{alp} start"
        raise NoMethodError if alp == 'c'
        #raise TypeError if alp == 'a'
        sleep 3
        puts "thread for #{alp} end"
      rescue NoMethodError
        puts 'no method error is rescued'
      ensure
        puts 'ensure section is executed'
      end
    end
  rescue TypeError
    #ここは実行されない親プロセスではキャッチできない
    puts 'type error is rescued'
  end
end
threads.each do |thread|
  thread.join
end
puts 'all thread end'


