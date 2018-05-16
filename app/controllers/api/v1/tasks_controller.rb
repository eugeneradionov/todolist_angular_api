class Api::V1::TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :project
  load_and_authorize_resource :task, through: :project

  resource_description do
    short 'Tasks which belongs to Project'
    formats ['json']
  end

  def_param_group :update_task do
    param :task, Hash, action_aware: true, required: true do
      param :project_id, :number, reuired: true
      param :name, String, required: true
      param :move, %w[1 -1], requred: false
    end
  end

  api :GET, '/projects/:project_id/tasks', 'Returns all tasks'
  def index
    render json: @tasks
  end

  api :POST, '/projects/:project_id/tasks', 'Creates new task'
  param_group :update_task
  def create
    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :PUT, '/projects/:project_id/tasks/:id', 'Updates task, selected by id'
  param_group :update_task
  param :id, :number, required: true
  def update
    if Api::V1::UpdateTaskService.new(@task, task_params).update
      render json: @project.tasks, status: :ok
    else
      render json: @task.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/projects/:project_id/tasks/:id', 'Destroys task, selected by id'
  param :id, :number, required: true
  def destroy
    @task.destroy
    render json: {}, status: :no_content
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :completed, :move)
  end
end
