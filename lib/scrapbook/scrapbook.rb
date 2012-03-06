require "rails/generators"

module Scrapbook
  class Scrapbook < Rails::Generators::Base

    source_root File.expand_path("../templates",__FILE__)

	  def create_initializer_file
	    copy_file "initializers/scrapbook.rb", "config/initializers/scrapbook.rb"
	  end

	  def create_cache_file
	    create_file "tmp/cache/scrapbook_cache", Time.now
	  end

	end

end