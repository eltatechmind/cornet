class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_task
  before_action :set_task_comment, only: [:show, :update, :destroy]

  # GET /tasks/:task_id/comments
  def index
    if @task.present?
      json_response(@task.comments)
    else
      head :not_found
    end
  end

  # GET /tasks/:task_id/comments/:id
  def show
    if @comment.present?
      json_response(@comment)
    else
      head :not_found
    end
  end

  # POST /tasks/:task_id/comments
  def create
    if @task.present?
      @task.comments.create!(comment_params)
      json_response(@task, :created)
    else
      head :unauthorized
    end
  end

  # PUT /tasks/:task_id/comments/:id
  def update
    if @comment.present?
      @comment.update(comment_params)
      head :no_content
    else
      head :not_found
    end
  end

  # DELETE /tasks/:task_id/comments/:id
  def destroy
    if @comment.present?
      @comment.destroy
      head :no_content
    else
      head :not_found
    end
  end

  private

  def set_current_user
     @user = current_user
  end

  def comment_params
    params.permit(:content, :task_id)
  end

  def set_task
    @task = Task.find(params[:task_id]) 
    @task = nil unless @task.project.user_id == @user.id
  end

  def set_task_comment
    if @task.present?
      @comment = @task.comments.find_by!(id: params[:id]) 
    else
      @comment = nil
    end
  end
end
