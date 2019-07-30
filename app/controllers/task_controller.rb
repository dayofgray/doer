class TaskController < ApplicationController

    get '/tasks' do #only if logged in, otherwise redirect to login page
                    # should only display my task

    end

    post '/tasks' do

    end

    get '/tasks/new' do

    end

    get '/task/:id' do

    end

    get '/task/:id/edit' do
        
    end

    patch '/task/:id' do

    end

    delete '/task/:id' do

    end

end