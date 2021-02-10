require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user(session)
        User.find(session[:user_id])
    end

    def is_logged_in?(session)
        session.key?(:user_id)
    end
  end
end
