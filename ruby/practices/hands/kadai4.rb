require 'mechanize'
require 'active_model'
require 'uri'
class Investigator
  include ActiveModel::Model
  attr_accessor :search_word, :successful
  def initialize *args
    @agent = Mechanize.new
    @investigated = false
    super *args
  end
  def find_text target_url
    @domain = target_url
    @agent.get(target_url)
    @successful = @agent.page.search('body').text.match(/#{@search_word}/)
  end
  def executable_links
    #access可能なリンク
    @agent.page.search("body").css("a").reject{|link| link['href'] =~ /javascript/  || link['href'] =~ /mailto/ }.map{|link| URI.join(@domain, link['href']).to_s.chomp('/') }
  end
end
class CrawlingRuler
  attr_reader :results
  #crawlingする時の動きを制御
  #各ページで何をするかはinvestigatorに任せる
  def initialize(domain, investigator)
    @investigator = investigator
    @domain = domain
    @results = []
    @visited = []
  end
  def valid_url link
    URI.parse(link).host == URI.parse(@domain).host
  end
  def crawl(target_url, search_word, consumed_time=0, histories=[])
    start_time = Time.now
    sleep 3
    histories = histories << target_url
    @visited = @visited << target_url
    #あればtrue ここではあったらそのページにあるリンクは探索しない
    @investigator.find_text(target_url)
    if @investigator.successful
      puts 'success'
      end_time = Time.now
      consumed_time = consumed_time + (end_time - start_time)
      @results << {consumed_time: consumed_time, histories: histories}
    else
      @investigator.executable_links.reject{|link_url| histories.include?(link_url) }.each do |link|
        end_time = Time.now
        consumed_time = consumed_time + (end_time - start_time)
        crawl(link.to_s, search_word, consumed_time, histories) if valid_url(link.to_s)
      end
    end
  end
end
#target_urlに対象のURLを指定
#sesarch_wordに検索文字列を指定
target_url = 'https://www.example.com'
search_word = 'aaa'
crawling_ruler = CrawlingRuler.new(target_url, Investigator.new(search_word: search_word))
crawling_ruler.crawl(target_url, search_word, consumed_time=0, histories=[])
puts crawling_ruler.results.sort{|a,b| a[:consumed_time] <=> b[:consumed_time] }.first
puts crawling_ruler.results.size
