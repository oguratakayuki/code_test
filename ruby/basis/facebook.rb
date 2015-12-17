module Facebook

  module Parser
    #共通処理
    def parse_feeds(feeds)
    end

    private
    def feed_pictures(feed_id)
    end

    def feed_movies(feed_id)
    end
  end

  class Page
    include Facebook::Reader

    def initialize(page_id, options)
      #ここがしたと違う
      @client = page_client_by_page_id
    end

    def feeds(option={})
      #ここがしたと違う
      feeds = page_feeds_api
      parse_feeds(feeds)
    end

  end

  class User
    include Facebook::Reader

    def initialize(token, options)
      #ここが上と違う
      @client = page_client_by_token
    end

    def feeds(option={})
      #ここが上と違う
      feeds = user_feeds_api
      parse_feeds(feeds)
    end
  end

end
