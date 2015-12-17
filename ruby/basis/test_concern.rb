module Concern
  def self.extended(base)
    puts 'extended(concern)'
  end
  def included(base = nil, &block)
    puts 'included(concern)'
    @_included_block = block
  end
  def append_features(base)
    puts 'append_feature is called'
    puts 'class_eval execute'
    base.class_eval(&@_included_block)
  end
end

#@_included_block = Proc.new do
#  def say
#    puts 'included'
#  end
#end

module AdditionalFunctions
  extend Concern
  included do
    puts 'included by concern'
    def say
      puts 'fuga'
    end
    def say2
      puts 'say2'
    end
  end
end

class Hoge
  include AdditionalFunctions
  def initialize
    puts 'initialize Hoge'
  end
  def say
    puts 'hoge'
  end
end

#matome concernをextendするとconcernをextendしているmoudleがincludeされるときにincludedが呼ばれる
#includedはconcernに定義されたメソッドでblockを引数にとるconcernのincludedメソッドが
#このblockを変数にいれておく
#concernをextendしたmoduleがincludeされるとconcernに定義されたappend_featuresが呼ばれる(rubyの仕様)そこででclass_evalして,includedメソッドで受け取ったblockによりmethodを追加している


#base.class_eval(&@_included_block) if instance_variable_defined?(:@_included_block)
#base.class_eval(&@_included_block)
hoge = Hoge.new
hoge.say
hoge.say2
