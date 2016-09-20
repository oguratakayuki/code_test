require 'mechanize'
require 'uri'
class Crawler
  attr_reader :results
  def initialize(url, word)
    @url = url
    @results = []
    shortest_url_path_word_exist(url, word, consumed_time=0, histories=[])
  end
  def shortest_url_path_word_exist(target_url, search_word, consumed_time=0, histories=[])
    if histories.size > 10
      puts 'force end'
      return false 
    end
    start_time = Time.now
    agent = Mechanize.new
    puts target_url
    sleep 1
    puts 'hey2'
    agent.get(target_url)
    puts 'hey3'
    histories = histories + agent.history.map(&:uri)
    if agent.page.search('body').text.match(/#{search_word}/)
      end_time = Time.now
      consumed_time = consumed_time + (end_time - start_time)
      @results << {consumed_time: consumed_time, histories: histories}
    else
      #puts agent.visited?('http://example.com')
      #puts agent.page.links[10].resolved_uri
      
      #agent.page.links.reject{|t| histories.include?(t.resolved_uri) }.each do |link|
      agent.page.search("body").css("a").map{|link| URI.join(@url, link['href']) }.reject{|link_url| histories.include?(link_url) }.each do |link|
        end_time = Time.now
        consumed_time = consumed_time + (end_time - start_time)
        puts 'hey'
        shortest_url_path_word_exist(link, search_word, consumed_time, histories)
      end
      #puts agent.history.map(&:uri)
      #search_world
    end
  end
end

target_url = 'https://www.menriku.com'
search_word = '男子スタッフを募集しておりますので'
crawler = Crawler.new(target_url, search_word)
puts crawler.results
