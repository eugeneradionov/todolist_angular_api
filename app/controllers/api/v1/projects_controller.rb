class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource through: :current_user

  resource_description do
    short 'Projects which belongs to current User'
    formats ['json']
  end

  def_param_group :update_project do
    param :project, Hash, action_aware: true, required: true do
      param :name, String, required: true
    end
  end

  api :GET, '/projects', "Returns all current User's projects"
  def index
    render json: @projects
  end

  api :POST, '/projects', 'Creates new project'
  param_group :update_project
  def create
    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :PUT, '/projects/:id', 'Updates project, selected by id'
  param_group :update_project
  param :id, :number, required: true
  def update
    if @project.update(project_params)
      render json: @project, status: :ok
    else
      render json: @project.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/projects/:id', 'Destroys project, selected by id, and all its tasks and comments'
  param :id, :number, required: true
  def destroy
    @project.destroy
    render json: {}, status: :no_content
  end

  private

  def project_params
    params.require(:project).permit(:id, :name)
  end
end
