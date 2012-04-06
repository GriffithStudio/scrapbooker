require "generators/scrapbooker"

require "scrapbooker/railtie" if defined? Rails
require "scrapbooker/base"
require "scrapbooker/configuration"
require "scrapbooker/utilities"
require "scrapbooker/helpers/helpers"
require "scrapbooker/services/services"

module Scrapbooker
end