require "spec_helper"

describe Scrapbooker::Helpers::TweetHelpers do
  
  before(:all) do
    @helper = class Helper
      include ActionView::Helpers
      include Scrapbooker::Helpers
    end.new
  end
  
  it "should return the tweet with hashtags linked" do
    test = @helper.expand_hashtag('#testing','This is a test #testing')
    result = "This is a test <a href=\"http://twitter.com/search/%23testing\" target=\"blank\">#testing</a>"
    test.should eq result
  end
  
  it "should return the tweet with mentions linked" do
    test = @helper.expand_mention('test','This is a test for @test')
    result = "This is a test for <a href=\"http://twitter.com/test\" target=\"blank\">@test</a>"
    test.should eq result
  end
  
  it "should return the tweet with links expanded and linked" do
    link = { 'source' => 'http://test.com', 'display' => 'http://test.com'}
    test = @helper.expand_link(link,'This is a test for http://test.com')
    result = "This is a test for <a href=\"http://test.com\" target=\"blank\">http://test.com</a>"
    test.should eq result
  end
  
  it "should return the tweet with media expanded and linked" do
    media = { 'source' => 'http://test.com/test.jpg', 'display' => 'http://test.com/test.jpg'}
    test = @helper.expand_media(media,'This is a test for http://test.com/test.jpg')
    result = "This is a test for <a href=\"http://test.com/test.jpg\" target=\"blank\">http://test.com/test.jpg</a>"
    test.should eq result
  end
  
end