require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:project) { FactoryBot.create(:project, user_id: user.id) }
  let(:task) { FactoryBot.create(:task, project_id: project.id) }
  let(:comments) { FactoryBot.create_list(:comment, 10, task_id: task.id) }

  let(:valid_params) do
    { project_id: task.project_id,
      task_id: task.id,
      comment: { body: 'Valid length comment' } }
  end

  let(:invalid_params) do
    { project_id: task.project_id,
      task_id: task.id,
      comment: { body: 'Short' } }
  end

  describe 'GET #index' do
    context 'authorized User' do
      it 'returns collection of projects with theirs comments', :show_in_doc do
        request.headers.merge!(user.create_new_auth_token)
        task = comments.first.task
        get :index, params: { project_id: task.project_id, task_id: task.id }
        expect(json.size).to eq(comments.size)
      end
    end

    context 'unauthorized User' do
      it 'returns HTTP Status 401' do
        task = FactoryBot.create(:comment).task
        get :index, params: { project_id: task.project_id, task_id: task.id }
        expect(response).to have_http_status 401
      end
    end
  end

  describe 'POST #create' do
    context 'valid params' do
      it 'returns HTTP Status 201', :show_in_doc do
        request.headers.merge!(user.create_new_auth_token)
        post :create, params: valid_params
        expect(response).to have_http_status 201
      end
    end

    context 'invalid params' do
      it 'returns HTTP Status 422', :show_in_doc do
        request.headers.merge!(user.create_new_auth_token)
        post :create, params: invalid_params
        expect(response).to have_http_status 422
      end
    end

    context 'unauthorized User' do
      it 'returns HTTP Status 401', :show_in_doc do
        post :create, params: valid_params
        expect(response).to have_http_status 401
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes comment and returns HTTP Status 204' do
      request.headers.merge!(user.create_new_auth_token)
      task = comments.first.task
      delete :destroy, params: { project_id: task.project_id,
                                 task_id: task.id,
                                 id: task.comments.first.id }

      expect(response).to have_http_status 204
    end
  end
end
