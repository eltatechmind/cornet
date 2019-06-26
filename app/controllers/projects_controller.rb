class ProjectsController < ApplicationController
  include Devise::Controllers::Helpers 
  before_action :authenticate_user!
  before_action :set_current_user
  before_action :set_project, only: [:show, :update, :destroy]
  
  # GET /projects
  def index
    json_response(@user.projects)
  end

  # POST /projects
  def create
    @project = Project.create!(project_params)
    json_response(@project, :created)
  end

  # GET /projects/:id
  def show
    if @project.present?
      json_response(@project)
    else
      head :not_found 
    end
  end

  # PUT /projects/:id
  def update
    if @project.present?
      @project.update(project_params)
      head :ok
    else
      head :unauthorized
    end
  end

  # DELETE /projects/:id
  def destroy
    if @project.present?
      @project.destroy 
      head :ok
    else
      head :unauthorized
    end
  end

  private

  def set_current_user
     @user = current_user
  end

  def project_params
    # whitelist params
    params.permit(:name).merge!(user_id: @user.id)
  end

  def set_project
    @project = Project.find(params[:id])
    @project = nil unless @project.user_id == @user.id
  end
end
