class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :task
  load_and_authorize_resource :comment, through: :task

  resource_description do
    short 'Comments which belongs to Task'
    formats ['json']
  end

  def_param_group :update_comment do
    param :comment, Hash, action_aware: true, required: true do
      param :project_id, :number, reuired: true
      param :task_id, :number, reuired: true
      param :body, String, required: true
      param :attachment, String, required: false, desc: 'Image'
    end
  end

  api :GET, '/projects/:project_id/tasks/:task_id/comments', 'Returns all comments'
  def index
    render json: @comments
  end

  api :POST, '/projects/:project_id/tasks/:task_id/comments', 'Creates new comment'
  param_group :update_comment
  def create
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/projects/:project_id/comments/:id', 'Destroys comment, selected by id'
  param :id, :number, required: true
  def destroy
    @comment.destroy
    render json: {}, status: :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :attachment)
  end
end
