
class UsersController < ApplicationController

    get '/users' do
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        erb :'users/show'
    end

    get '/signup' do
        if !is_logged_in?(session)
            erb :'users/create_user'
        else
            redirect '/tweets'
        end
    end

    get '/login' do
        if !is_logged_in?(session)
            erb :'users/login'
        else
            redirect '/tweets'
        end
    end

    get '/logout' do
        if is_logged_in?(session)
            session.clear
            redirect '/login'
        else
            redirect '/'
        end
    end

    post '/signup' do
        @user = User.create(params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    post '/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        else
            redirect '/login'
        end
    end
    
end

