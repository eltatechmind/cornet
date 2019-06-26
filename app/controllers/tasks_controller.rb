class TasksController < ApplicationController
  include Devise::Controllers::Helpers 
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_project, only: [:create]
  before_action :set_task, only: [:show, :update, :destroy]
  
  # GET /tasks
  def index
    tasks = Task.joins(project: [:user]).where(users: {id: @user.id})
    json_response(tasks)
  end

  # POST /tasks
  def create
    if @project.present?
      @task = Task.create!(task_params)
      json_response(@task, :created)
    else
      head :unauthorized
    end
  end

  # GET /tasks/:id
  def show
    if @task.present?
      json_response(@task)
    else
      head :not_found 
    end
  end

  # PUT /tasks/:id
  def update
    if @task.present?
      @task.update(task_params)
      head :ok
    else
      head :unauthorized
    end
  end

  # DELETE /tasks/:id
  def destroy
    if @task.present?
      @task.destroy 
      head :ok
    else
      head :unauthorized
    end
  end

  private
  
  def set_current_user
     @user = current_user
  end

  def task_params
    # whitelist params
    params.permit(:name, :project_id, :plevel, :deadline, :done)
  end

  def set_project
    @project = Project.find(params[:project_id])
    @project = nil unless @project.user_id == @user.id
  end

  def set_task
    @task = Task.find(params[:id])
    @task = nil unless @task.project.user_id == @user.id
  end
end
