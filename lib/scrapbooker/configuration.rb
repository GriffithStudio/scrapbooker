module Scrapbooker
  class Configuration
    
    def update_interval=(minutes)
      @interval = minutes
    end
    
    def update_interval
      @interval = @interval ? @interval : 1440 #The default interval in minutes (24 hours)
    end
    
    def timestamp_storage=(path)
      @timestamp_storage = path
    end
    
    def timestamp_storage
      @timestamp_storage = @timestamp_storage ? @timestamp_storage : "#{Rails.root}/tmp"
    end
    
    def twitter_feed=(options)
      @twitter_feed = options
    end
    
    def twitter_feed
      @twitter_feed
    end
    
  end
end