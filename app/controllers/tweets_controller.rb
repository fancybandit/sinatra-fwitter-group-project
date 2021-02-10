
class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?(session)
            @user = current_user(session)
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if is_logged_in?(session)
            @user = current_user(session)
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if @tweet && is_logged_in?(session)
            @user = current_user(session)
            erb :'tweets/show_tweet'
        elsif is_logged_in?(session)
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && is_logged_in?(session)
            @user = current_user(session)
            erb :'tweets/edit_tweet'
        elsif is_logged_in?(session)
            redirect '/tweets'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if is_logged_in?(session)
            @user = current_user(session)
            @tweet = Tweet.create(content: params[:content], user_id: @user.id)
            if @tweet.valid?
                redirect '/tweets'
            else
                redirect '/tweets/new'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        @user = current_user(session)
        @test_tweet = Tweet.new(content: params[:content], user_id: @user.id)
        if is_logged_in?(session) && (params[:content] != @tweet.content)
            if @test_tweet.valid?
                @tweet.update(content: params[:content])
                redirect "/tweets/#{@tweet.id}"
            else
                redirect "/tweets/#{@tweet.id}/edit"
            end
        elsif is_logged_in?(session)
            redirect "/tweets/#{@tweet.id}"
        else
            redirect "/login"
        end
    end

    delete '/tweets/:id' do
        if is_logged_in?(session)
            @user = current_user(session)
            @tweet = Tweet.find_by_id(params[:id])
            if @tweet.user_id == @user.id
                @user.tweets.find_by_id(params[:id]).destroy
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

end

