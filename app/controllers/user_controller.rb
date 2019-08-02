class UserController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect '/tasks'
        else
        erb :'users/signup'
        end
    end

    post '/users' do ##add error for incomplete and possible email validation
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
            login(params[:username], params[:password])
            redirect '/tasks'
        else
            redirect '/signup' #need error message here
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