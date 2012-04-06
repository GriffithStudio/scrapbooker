ActiveRecord::Schema.define :version => 0 do
  create_table "scrapbooks", :force => true do |t|
    t.boolean   :display, :default => true
    t.text      :entry
    t.datetime  :posted_at
    t.text      :raw_feed
    t.string    :source
    t.integer   :source_id, :limit => 8
    t.timestamps
  end
end