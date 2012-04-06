module Scrapbooker
  module Helpers
    module TweetHelpers
    
      def render_tweet(tweet)
        rendered_tweet = tweet.entry
    		tweet.hashtags.each { |hashtag| expand_hashtag(hashtag,rendered_tweet) }
    		tweet.mentions.each { |mention| expand_mention(mention,rendered_tweet) }
    		tweet.links.each { |link| expand_link(link,rendered_tweet) }
    		tweet.media.each { |media| expand_media(media,rendered_tweet) }
        return raw rendered_tweet
      end

      def expand_hashtag(hashtag,tweet)
        tweet.sub!("#{hashtag}", link_to(hashtag,"http://twitter.com/search/#{URI.escape(hashtag)}",:target => :blank))
      end

      def expand_link(link,tweet)
        tweet.sub!(link['display'], link_to(link['source'],link['source'],:target => :blank))
      end

      def expand_media(media,tweet)
        tweet.sub!(media['display'], link_to(media['source'],media['source'],:target => :blank))
      end

      def expand_mention(mention,tweet)
        tweet.sub!(/@#{mention}/i, link_to("@#{mention}","http://twitter.com/#{mention}",:target => :blank))
      end
    
    end
  end
end