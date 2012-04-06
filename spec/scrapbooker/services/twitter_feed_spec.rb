require "spec_helper"

describe Scrapbooker::Services::TwitterFeed do
  
  use_vcr_cassette "twitter_feed"
  
  before(:all) do
    clean_database!
    reset_scrapbook
    Scrapbook.configuration.twitter_feed = {  :username => 'GriffithStudio', 
                                              :include_entities     => true,
                                              :exclude_replies      => false,
                                              :count                => 50,
                                              :trim_user            => false } 
                                                                                         
  end
  
  it "polls twitter and stores tweets in the database" do
    Scrapbook.poll_twitter?
    Scrapbook.count.should > 0
  end
  
  it "checks for the retweet status" do
    tweet = Scrapbook.find_by_source_id(169118526404165632)
    tweet.is_retweet.should eq true
  end
  
  it "returns the links from a tweet" do
    tweet = Scrapbook.find_by_source_id(187542378033332224)
    tweet.links.first['display'].should eq "http://t.co/UAWQ5u27"
  end
  
  it "returns the media from a tweet" do
    tweet = Scrapbook.find_by_source_id(185131786605563904)
    tweet.media.first['display'].should eq "http://t.co/XiIWPrJn"
  end
  
  it "returns the mentions from a tweet" do
    tweet = Scrapbook.find_by_source_id(181838740447182848)
    tweet.mentions.first.should eq "mrwhite_"
  end
  
  it "returns the hashtags from a tweet" do
    tweet = Scrapbook.find_by_source_id(172399167614881792)
    tweet.hashtags.last.should eq "#desert"
  end
  
end