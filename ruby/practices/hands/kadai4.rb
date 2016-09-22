require 'mechanize'
require 'uri'
class Crawler
  attr_reader :results
  def initialize(domain, word)
    @domain = domain
    @results = []
    @visited = []
    @total_loop_count_for_debug = 0
    shortest_url_path_word_exist(@domain, word, consumed_time=0, histories=[])
  end
  def valid_url link
    URI.parse(link).host == URI.parse(@domain).host
  end
  def shortest_url_path_word_exist(target_url, search_word, consumed_time=0, histories=[])
    @total_loop_count_for_debug = @total_loop_count_for_debug + 1
    return false if @total_loop_count_for_debug > 15
    if @visited.any?{|visited| URI(visited) == URI(target_url)}
      abort 'HEEERE'
      return false 
    else
      puts 'not visit'
      puts target_url
    end
    if histories.size > 2
      puts 'visited'
      return false
    end
    start_time = Time.now
    agent = Mechanize.new
    sleep 3
    agent.get(target_url)
    histories = histories + agent.history.map(&:uri)
    @visited = @visited + agent.history.map(&:uri)
    if agent.page.search('body').text.match(/#{search_word}/)
      puts 'success'
      end_time = Time.now
      consumed_time = consumed_time + (end_time - start_time)
      @results << {consumed_time: consumed_time, histories: histories}
    else
      links = agent.page.search("body").css("a").reject{|link| link['href'] =~ /javascript/  || link['href'] =~ /mailto/ }.map{|link| URI.join(@domain, link['href']) }
      links.reject{|link_url| @visited.include?(link_url) }.each do |link|
        end_time = Time.now
        consumed_time = consumed_time + (end_time - start_time)
        shortest_url_path_word_exist(link.to_s, search_word, consumed_time, histories) if valid_url(link.to_s)
      end
    end
  end
end

target_url = 'https://www.menriku.com'
search_word = '男子スタッフを募集しておりますので'
search_word = '兵庫'
crawler = Crawler.new(target_url, search_word)
puts 'END!!!!'
puts crawler.results.sort{|a,b| a[:consumed_time] <=> b[:consumed_time] }.first
puts crawler.results.size
