require './config/environment' 

class ApplicationController < Sinatra::Base
    register Sinatra::Flash

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, '92406-secret'
    end

    helpers do
        def current_user
            @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
        end

        def logged_in?
            !!session[:user_id]
        end

        def login(uname, password)
            @user = User.find_by(username: uname)
            if @user && @user.authenticate(password)
                session[:user_id] = @user.id
            else
                redirect '/login'
            end
        end

        def logout
            session.clear
        end

    end

    get '/' do
        if logged_in?
          redirect '/tasks'
        else
          erb :'index'
        end
    end

end