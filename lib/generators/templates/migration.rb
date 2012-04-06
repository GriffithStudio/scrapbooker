class Create<%= @class_name.pluralize.camelize -%> < ActiveRecord::Migration
  def self.up
    create_table :<%= @class_name.pluralize -%> do |t|
      t.boolean   :display, :default => true
      t.text      :entry
      t.datetime  :posted_at
      t.text      :raw_feed
      t.string    :source
      t.integer   :source_id, :limit => 8
      t.timestamps
    end
  end

  def self.down
    drop_table :<%= @class_name.pluralize -%>
  end
end