module Scrapbooker
  module Base
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    module ClassMethods
      def extend_with_scrapbooker
        
        include Scrapbooker::Services
        
        extend Scrapbooker::Utilities
        extend Scrapbooker::Services
        
        validates_uniqueness_of :source_id, :scope => :source
        
      end
    end
  end
end