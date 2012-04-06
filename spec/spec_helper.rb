$LOAD_PATH << "." unless $LOAD_PATH.include?(".")

require "rubygems"
require "rails/all"
require "scrapbooker"
require "twitter"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir     = 'spec/support/cassettes'
  config.hook_into                :fakeweb
  config.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend VCR::RSpec::Macros
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ":memory:")

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  load(File.dirname(__FILE__) + '/schema.rb')
  load(File.dirname(__FILE__) + '/models.rb')
end

def clean_database!
  ActiveRecord::Base.connection.execute "DELETE FROM #{Scrapbook.table_name}"
end

clean_database!

def reset_scrapbook
  Scrapbook.configuration.update_interval = nil
  Scrapbook.configuration.twitter_feed = nil
  # Set the timestamp_storage to the tmp directory in support.
  Scrapbook.configuration.timestamp_storage = File.dirname(__FILE__) + '/support/tmp'
end
