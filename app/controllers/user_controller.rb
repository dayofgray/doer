class UserController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/users' do
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
    end

end