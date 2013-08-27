get '/' do
  if @user = params[:twitter_username]
    redirect "/#{@user}"
  else
    erb :index
  end
end

#-------GET TWEETS-------
get '/:username' do  
  p "im here"
  p params
  @user = User.find_or_create_by_username(params[:twitter_username])
  if @user.tweets.empty?
    user_tweets = Twitter.user_timeline(@user.username)
    user_tweets.each do |tweet|
      new_tweets = Tweet.create(tweet: tweet.text, user_id: @user.id, tweeted_at: tweet.created_at, profile_image_url: tweet.profile_image_url)
      @user.tweets << new_tweets
    end
    erb :view_tweets, layout: false
    # User#fetch_tweets! should make an API call
    # and populate the tweets table
    #
    # Future requests should read from the tweets table
    # instead of making an API call
    # @user.fetch_tweets!
  else
    if @user.tweets_stale?
      @user.fetch_tweets!
      erb :view_tweets, layout: false
    else
      @user
      p @user.tweets
      erb :view_existing_tweets, layout: false
    # grab last tweet from twitter api
    # pop off last tweet from stored tweets arrray
    # if theyre the same
    #   return the tweets in the database
    # else
    #   scrap the twitter api for last ten tweets and save to db
    #   display new tweet data
    end
  end
end

#----------- Post Tweets ------- 

post '/post_tweet' do 
 tweet = Twitter.update(params[:tweet])
end
