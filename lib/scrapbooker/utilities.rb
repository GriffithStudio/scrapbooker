module Scrapbooker
  module Utilities
    
    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
    
    def update_scrapbook?
      update_scrapbook if !timestamp_exists?
      update_scrapbook if !timestamp_is_current?
    end
    
    def update_scrapbook
      #Get results from active services
      poll_twitter?
      update_timestamp
    end
    
    def timestamp_is_current?
      last_update > self.configuration.update_interval.minutes.ago
    end
    
    def timestamp_exists?
      File.exists?(timestamp_file) ? true : false
    end
    
    def update_timestamp
      File.open(timestamp_file, "w+") {|f| f.write(Time.now)}
    end
    
    def timestamp_file
      "#{self.configuration.timestamp_storage}/#{self.name.underscore}_last_update"
    end
    
    def last_update
    	Time.parse(File.read(timestamp_file))
    end
    
  end
end