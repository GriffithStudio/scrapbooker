require 'rails/generators'

class ScrapbookerGenerator < Rails::Generators::NamedBase  
  include Rails::Generators::Migration
  
  source_root File.expand_path("../templates",__FILE__)
  
  attr_accessor :class_name
  
  def initialize(args,*)
    super
    given_name = args.first
    @class_name = test_singularity(given_name) ? given_name.underscore : given_name.singularize.underscore
  end

  def create_model
    template "model.rb", "app/models/#{@class_name}.rb"
  end
  
  def create_migration
    migration_template "migration.rb", "db/migrate/#{migration_file_name}"
  end
  
  @@migrations = false

  def self.next_migration_number(dirname)
    if ActiveRecord::Base.timestamped_migrations
      if @@migrations          
        (current_migration_number(dirname) + 1)
      else
        @@migrations = true
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      end
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end  
  
  
  protected

  def migration_name
    "create_#{@class_name.pluralize}"
  end
  
  def migration_file_name
    "#{migration_name}.rb"
  end
    
  def test_singularity(str)
    str.pluralize != str and str.singularize == str
  end

end

