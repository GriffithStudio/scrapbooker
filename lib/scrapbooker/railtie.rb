module Scrapbooker
  class Railtie < Rails::Railtie
    initializer 'scrapbooker.initialize' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Scrapbooker::Base
        ActionView::Base.send :include, Scrapbooker::Helpers
      end
    end
  end
end