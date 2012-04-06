require 'twitter'

module Scrapbooker
  module Services
    
    class TwitterFeed
      def self.default_options
        @default_options ||= {
          :username               => nil,
          :include_retweets       => true,
          :exclude_replies        => true,
          :include_entities       => true,
          :count                  => 20,
          :trim_user              => true
        }
      end
      
      attr_reader :username, :include_retweets, :exclude_replies, :include_entities, :count, :trim_user, :active
      
      def initialize(options)
        @active = options ? true : false
        options ||= {}
        options = self.class.default_options.merge(options)
        @username = options[:username]
        @include_retweets = options[:include_retweets]
        @exclude_replies = options[:exclude_replies]
        @include_entities = options[:include_entities]
        @count = options[:count]
        @trim_user = options[:trim_user]
      end
    end
    
    def poll_twitter?
      poll_twitter if self.twitter_feed.active
    end
    
    def poll_twitter
      results = Twitter.user_timeline(self.twitter_feed.username, {
        :include_rts              => self.twitter_feed.include_retweets, 
        :include_replies          => self.twitter_feed.exclude_replies,
        :include_entities         => self.twitter_feed.include_entities,
        :count                    => self.twitter_feed.count,
        :trim_user                => self.twitter_feed.trim_user
      })
      for tweet in results do
        store_tweet(tweet)
      end
    end
    
    def store_tweet(tweet)
      self.create( 
        :source                   => 'twitter', 
        :source_id                => tweet.id, 
        :raw_feed                 => tweet.instance_variable_get('@attrs').to_yaml,
        :posted_at                => tweet.created_at,
        :entry                    => tweet.text
      )
    end
    
    module TweetMethods
      
      def original_tweet
        YAML::load(self.raw_feed)
      end
      
      def is_retweet
        self.original_tweet['retweeted_status'] ? true : false
      end
      
      def links
        links = Array.new
        if self.original_tweet['entities'] && self.original_tweet['entities']['urls']
          for link in self.original_tweet['entities']['urls'] do
            link_hash = Hash['source', link['expanded_url'], 'display', link['url']] 
            links << link_hash
          end
        end
        return links
      end
      
      def media
        media = Array.new
        if self.original_tweet['entities'] && self.original_tweet['entities']['media']
          for entity in self.original_tweet['entities']['media'] do
            media_hash = Hash['source', entity['media_url'], 'display', entity['url'], 'type', entity['type']]
            media << media_hash
          end
        end
        return media
      end
      
      def mentions
        mentions = Array.new
        if self.original_tweet['entities'] && self.original_tweet['entities']['user_mentions']
          for mention in self.original_tweet['entities']['user_mentions'] do
            mentions << "#{mention['screen_name']}"
          end
        end
        return mentions
      end
      
      def hashtags
        hashtags = Array.new
        if self.original_tweet['entities'] && self.original_tweet['entities']['hashtags']
          for hashtag in self.original_tweet['entities']['hashtags'] do
            hashtags << "##{hashtag['text']}"
          end
        end
        return hashtags
      end
      
    end
    
    include TweetMethods

  end
end