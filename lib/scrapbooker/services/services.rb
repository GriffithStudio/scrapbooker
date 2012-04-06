require "scrapbooker/services/twitter_feed"

module Scrapbooker
  module Services
    
    def twitter_feed
      @twitter_feed ||= TwitterFeed.new(self.configuration.twitter_feed)
    end
    
  end
end