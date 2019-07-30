class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/users' do
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        if @user.save
            erb :'tasks/tasks'
        else
            redirect '/signup' #need error message here
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
    end

    get '/logout' do
        logout
        redirect '/'
    end

end