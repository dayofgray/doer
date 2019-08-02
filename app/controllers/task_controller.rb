class TaskController < ApplicationController

    get '/tasks' do
      if logged_in?
        if !Task.where(user_id: session[:user_id]).empty?
          @tasks=Task.where(user_id: session[:user_id])
          erb :'tasks/tasks'
        else
          flash[:tasks] = "You have no tasks, feel free to create one."
          redirect '/tasks/new' 
        end 
      else
        flash[:error] = "You must be logged in to view your tasks"
        redirect '/login'                # should only display my task
      end
    end

    post '/tasks' do
        if !params[:task].has_value?("")
        @task=Task.new(params[:task])
            @task.user_id = session[:user_id]
            if @task.save
                erb :'tasks/show'
            else
            flash[:error] = "You must create a valid task"
            redirect '/tasks/new'
            end
        else
            flash[:error] = "You must fill out each field"
            redirect '/tasks/new' 
        end
    end

    get '/tasks/new' do
        if logged_in?
            erb :'tasks/new'
        else
            redirect '/login'
        end
    end

    get '/tasks/:id' do
        @task = Task.find(params[:id])   
        if logged_in? && @task.user_id == session[:user_id]
            erb :'tasks/show'
        elsif logged_in?
            flash[:ownership] = "This task does not belong to you"
            redirect '/tasks'
        else 
            flash[:error] = "You must be logged in to view your tasks"
            redirect '/login'  
        end
    end

    get '/tasks/:id/edit' do
        @task = Task.find(params[:id])   
        if logged_in? && @task.user_id == session[:user_id]
            erb :'tasks/edit'
        elsif logged_in?
            flash[:ownership] = "This task does not belong to you"
            redirect '/tasks'
        else 
            flash[:error] = "You must be logged in to view your tasks"
            redirect '/login' 
        end
    end

    patch '/tasks/:id' do
        if logged_in?
        @task = Task.find(params[:id])
            if params[:title] != ""
                @task.title = params[:title]
            end
            if params[:due_date] != ""
                @task.due_date = params[:due_date]
            end
            if params[:priority] != ""
                @task.priority = params[:priority]
            end
            redirect "/tasks/#{@task.id}"
        else
            redirect '/login'
        end
    end

    delete '/tasks/:id' do
        @task = Task.find(params[:id])   
        if logged_in? && @task.user_id == session[:user_id]
            @task.delete
            redirect '/tasks'
        else
            redirect '/login'
        end
    end

end