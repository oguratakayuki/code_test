class Event
  def initialize
    @configurations ={}
  end
  #def configuration(case)
  #  conf = Configuration.new
  #  yield(conf) if block_given?
  #  @configurations[case] = conf
  #end

  def configuration(on, &block)
    @configurations[on] = block
  end

  def execute(on)
    conf = Configuration.new
    @configurations[on].call(conf)
    puts "type=#{conf.type}, place=#{conf.place}, time=#{conf.time}"
  end


  class Configuration
    attr_accessor :place, :type, :time
    def initialize
      @place = :default
      @type = :default
      @time = :default
    end
  end
end

event = Event.new
event.configuration(:morning) do |c|
  c.type = :all_day
  c.place = :tokyo
  c.time = nil
end

event.configuration(:night) do |c|
  c.type = :half_hour
  c.place = :osaka
  c.time = nil
end

event.execute(:morning)
event.execute(:night)



#eventの中のconfには直接アクセスさせない.
# x event.conf.place = :hoge
# 上記の用に書くより設定ファイルの記述に近く見通しが良い
#blockで設定を渡すことで実行するタイミングを制御できる
