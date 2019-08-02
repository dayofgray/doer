class UserController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/tasks'
        else
        erb :'users/signup'
        end
    end

    post '/users' do
        if params[:username] != "" && params[:email] != "" && params[:password] != "" && params[:email].include?("@")
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
            login(params[:username], params[:password])
            redirect '/tasks'
        else
            flash[:error] = "Please enter valid credentials"
            redirect '/signup'
        end
        else
            flash[:error] = "Please enter valid credentials"
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tasks'
        else
        erb :'users/login'
        end
    end

    post '/login' do
        login(params[:username], params[:password])
        redirect '/tasks'
    end

    get '/logout' do
        logout
        redirect '/'
    end

end