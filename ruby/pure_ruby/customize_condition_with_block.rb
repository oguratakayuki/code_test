class Event
  def initialize
    @conf = Configuration.new
  end
  def configuration
    yield(@conf) if block_given?
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
event.configuration do |c|
  c.place = :tokyo
  c.type = :all_day
  c.time = nil
end
#eventの中のconfには直接アクセスさせない.
# x event.conf.place = :hoge
#blockで設定を渡すことで
