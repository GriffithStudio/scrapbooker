# Scrapbooker

Scrapbooker is a gem for rails that allows you to pull information from social media feeds then store the information locally. This is handy for keeping an archive of activity, but also a good way to make that content available to your Rails app.

## Installation

The scrapbooker gem makes use of railties, and as such requires Rails version >= 3.0. 

Installing the gem is as simple as adding it your gemfile.

    gem "scrapbooker"

This will also install the latest version of the gem, plus any dependencies that you may need to connect to the various services including:

+ twitter
+ simple_oauth
+ addressable
+ multipart-post
+ faraday

## Usage

The gem provides a generator for getting started quickly. Running the generator will create a model and migration in you app. As an example, I can to create a new class called `Scrapbook` by running the following command.

    rails g scrapbooker Scrapbook

Once the new scrapbook migration has been created, run the migration.

    rake db:migrate
    
The new `scrapbook.rb` model contains `extend_with_scrapbooker`. This extends the class with the scrapbooker functionality. The scrapbooker configuration can be set by passing the settings in a `configure` block.

In the example, the Scrapbook class is going to store tweets from [@GriffithStudio](http://twitter.com/GriffithStudio) and check for new tweets every hour. In the `scrapbook.rb` model, the following should be added.

    self.configure do |c|
      c.update_interval = 60
      c.twitter_feed = { :username => 'GriffithStudio' }
    end

Now, the method `update_scrapbook` can be called on the Scrapbook class to pull any new tweets into the application. A before_filter can also be setup in the controller to perform the update at the specified interval. For this, the following can be added to the application controller.

    before_filter :update_scrapbook

    private

    def update_scrapbook
      Scrapbook.update_scrapbook?
    end

The Scrapbook class can be used anywhere in the application, just as any other class. for instance the following calls the first Scrapbook entry.

    Scrapbook.first

Scrapbooker also extends the Scrapbook class with the a few unique attributes.

    Scrapbook.first.original_tweet
    Scrapbook.first.is_retweet
    Scrapbook.first.links
    Scrapbook.first.media
    Scrapbook.first.mentions
    Scrapbook.first.hashtags

In the application views, scrapbooker adds a few helper methods.

    render_tweet Scrapbook.first

The helper methods can all be overridden in the application helpers.

## Testing

Testing the gem makes use of the [`vcr`](https://github.com/myronmarston/vcr) gem from Myron Marston in order to playback specific HTTP responses. This is fantastic for testing, but be warned that the tests are very brittle.

## Credits

The gem is being developed as a collaboration between [@GriffithStudio](http://twitter.com/GriffithStudio) and [@ContrarySheep](http://twitter.com/ContrarySheep). 

##License

Scrapbooker is (c) 2012 Christopher Griffith Studio. It is free software, and may be redistributed under the terms specified in the LICENSE file.
