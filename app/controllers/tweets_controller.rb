class TweetsController < ApplicationController
    def create
        @tweet= Tweet.new(tweet_params)
        
        if @tweet.save
            render 'tweets/create'
        end
    end

    def create
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)
        user = session.user
    
        @tweet = user.tweets.new(tweet_params)
    
        render 'tweets/create' if @tweet.save
      end

    def index
        @tweets=Tweet.all
        render 'tweets/index'

    end

    def destroy
        token = cookies.signed[:twitter_session_token]
        session = Session.find_by(token: token)
    
        return render json: { success: false } unless session
    
        user = session.user
        tweet = Tweet.find_by(id: params[:id])
    
        if tweet && tweet.destroy
          render json: {
            success: true
          }
        else
          render json: {
            success: false
          }
        end
      end

    def index_by_user
        user = User.find_by(username: params[:username])

        if user
            @tweets = user.tweets
            render 'tweets/index'
        end
    end

    def tweet_params
        params.require(:tweet).permit(:message)
    end

end
