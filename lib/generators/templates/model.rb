class <%= @class_name.camelize -%> < ActiveRecord::Base
  
  extend_with_scrapbooker
  
  #
  # Example Scrapbooker configuration settings. Refer to documentation for other configuration options.
  #
  # self.configure do |c|
  #   c.update_interval = 60 # In minutes
  #   c.twitter_feed = { :username => 'username', :include_retweets => true }
  # end
  #
    
end