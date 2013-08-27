class AddToTweets < ActiveRecord::Migration
  def change
  	add_column :tweets, :tweeted_at, :datetime
  	add_column :tweets, :profile_image_url, :string
  end
end
