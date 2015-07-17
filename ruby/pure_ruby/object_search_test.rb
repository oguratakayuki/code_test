class Piyo
  def initialize
    @name2 = 'piyo desu'
    @detail2 = 'piyo detail desu'
  end
end

class Hoge
  def initialize
    @name = 'hoge desu'
    @detail = 'hoge detail desu'
    @piyo_instance = Piyo.new
    @array = []
    @hash = {}
    @int = 1
  end
end

def r_obj_search(obj,search_value=nil, prefix='')
  obj.instance_variables.each do |t|
    unless [Hash, String, Integer, Array, Symbol].include?(obj.instance_variable_get(t).class)
      if obj.instance_variable_get(t).instance_variables.count > 0
        prefix = "#{prefix}->#{obj.instance_variable_get(t).class}"
        r_obj_search(obj.instance_variable_get(t), search_value, prefix)
      end
    else
      puts "#{prefix}->#{t} = #{obj.instance_variable_get(t)}"
    end
  end
end

h = Hoge.new
r_obj_search(h)
