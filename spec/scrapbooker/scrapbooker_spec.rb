require "spec_helper"

describe Scrapbooker do
    
  before(:each) do
    clean_database!
    reset_scrapbook
  end
  
  it "tests the timestamp file" do
    Scrapbook.update_timestamp
    Scrapbook.last_update.strftime("%H:%M:%S").should eq Time.now.strftime("%H:%M:%S")
  end
  
  it "tests the ability to add a database entry" do
    scrapbook = Scrapbook.create(:source => "test")
    scrapbook.source.should eq "test"
  end
  
end