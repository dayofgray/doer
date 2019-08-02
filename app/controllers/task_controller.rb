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
        redirect '/login'               
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
        @task = Task.find(params[:id])
        if logged_in? && params[:task][:title] != "" && params[:task][:due_date] != ""
                @task.title = params[:task][:title]
                @task.due_date = params[:task][:due_date]
                @task.priority = params[:task][:priority]
                @task.save
            redirect "/tasks/#{@task.id}"
        elsif params[:task][:title] == "" || params[:task][:due_date] == ""
            flash[:error] = "Your task must have a Title and Due Date"
            redirect "/tasks/#{@task.id}/edit" 
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