# frozen_string_literal: true

class CommentsController < ApplicationController
  require 'csv'
  require 'net/http'
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_task, except: [:csv_files, :display_csv_imported]
  before_action :set_task_comment, only: [:show, :update, :destroy], except: [:csv_files, :display_csv_imported]

  # GET /tasks/:task_id/comments
  def index
    if @task.present?
      json_response(@task.comments)
    else
      head(:not_found)
    end
  end

  # GET /tasks/:task_id/comments/:id
  def show
    if @comment.present?
      json_response(@comment)
    else
      head(:not_found)
    end
  end

  # POST /tasks/:task_id/comments
  def create
    if @task.present?
      @task.comments.create!(comment_params)
      json_response(@task, :created)
    else
      head(:unauthorized)
    end
  end

  # PUT /tasks/:task_id/comments/:id
  def update
    if @comment.present?
      @comment.update(comment_params)
      head(:no_content)
    else
      head(:not_found)
    end
  end

  # DELETE /tasks/:task_id/comments/:id
  def destroy
    if @comment.present?
      @comment.destroy
      head(:no_content)
    else
      head(:not_found)
    end
  end

  def csv_files
    @comment = Comment.find(params[:comment_id])
    if @comment.task.project.user_id == @user.id
      ProcessCsv.new(params[:url], @comment.id).proce
    else
      head(:unauthorized)
    end
  end

  def display_csv_imported
    @comment = Comment.find(params[:comment_id])
    if @comment.task.project.user_id == @user.id
      render(json: @comment.mycsvs, status: :ok)
    else
      head(:unauthorized)
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def comment_params
    params.permit(:content, :task_id, :url, :comment_id)
  end

  def set_task
    @task = Task.find(params[:task_id])
    @task = nil unless @task.project.user_id == @user.id
  end

  def set_task_comment
    @comment = if @task.present?
      @task.comments.find_by!(id: params[:id])
    end
  end
end
