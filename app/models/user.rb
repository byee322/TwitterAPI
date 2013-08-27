require 'date'

class User < ActiveRecord::Base

  has_many :tweets

  def tweets_stale?
    if self.tweets.first[:created_at] < (Time.now - 900)
      return true
    end
  end

  def fetch_tweets!
    self.tweets.destroy_all
    new_tweets = Twitter.user_timeline(self.username)
    new_tweets.each do |tweet|
      brand_new_tweets = Tweet.create(tweet: tweet.text, user_id: self.id)
      self.tweets << brand_new_tweets
    end
  end

end
