class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, '92406-secret'
    end

    helpers do
        
    end

    get '/' do
        
        erb :'index'
    end



end