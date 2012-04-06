class Scrapbook < ActiveRecord::Base
  include Scrapbooker::Base
  extend_with_scrapbooker
end