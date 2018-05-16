require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:project) { FactoryBot.create(:project, user_id: user.id) }
  let(:tasks) { FactoryBot.create_list(:task, 5, project_id: project.id) }

  before(:each) do
    request.headers.merge!(user.create_new_auth_token)
  end

  let(:valid_params) do
    { name: FFaker::Movie.unique.title,
      project_id: project.id,
      deadline: Time.zone.tomorrow }
  end

  let(:invalid_params) do
    { name: '',
      deadline: Time.zone.yesterday,
      project_id: project.id }
  end

  let(:task_valid_params) do
    { name: 'New owesome name',
      done: true,
      deadline: Time.zone.tomorrow,
      project_id: project.id }
  end

  let(:task_invalid_params) do
    { deadline: Time.zone.yesterday,
      project_id: project.id }
  end

  describe 'GET #index' do
    it 'returns HTTP Status 200' do
      tasks
      get :index, params: { project_id: project.id }
      expect(response).to have_http_status 200
    end

    it 'returns collection of Tasks', :show_in_doc do
      tasks
      get :index, params: { project_id: project.id }
      expect(json.size).to eq(tasks.size)
    end
  end

  describe 'POST #create' do
    context 'valid params' do
      it 'returns HTTP Status 201', :show_in_doc do
        post :create, params: { project_id: project.id, task: valid_params }
        expect(response).to have_http_status 201
      end

      it 'increase tasks count' do
        expect do
          post :create, params: { project_id: project.id, task: valid_params }
        end.to change(Task, :count).by 1
      end
    end

    context 'invalid params' do
      it 'returns HTTP Status 422', :show_in_doc do
        post :create, params: { project_id: project.id, task: invalid_params }
        expect(response).to have_http_status 422
      end
    end
  end

  describe 'PUT #update' do
    context 'valid params' do
      it 'returns HTTP Status 200', :show_in_doc do
        put :update, params: { id: tasks.sample.id, task: task_valid_params,
                               project_id: project.id }
        expect(response).to have_http_status 200
      end
    end

    context 'move task by one position up' do
      it 'returns HTTP Status 200' do
        put :update,
            params: { id: tasks.last.id, task: { move: '1' },
                      project_id: project.id }
        expect(response).to have_http_status 200
      end
    end

    context 'move task by one position down' do
      it 'update task position' do
        put :update,
            params: { id: tasks.first.id, task: { move: '-1' },
                      project_id: project.id }
        expect(response).to have_http_status 200
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes task and returns HTTP Status 204', :show_in_doc do
      tasks
      expect do
        delete :destroy, params: { project_id: project.id, id: tasks.sample.id }
      end.to change(Task, :count).by(-1)
      expect(response).to have_http_status 204
    end
  end
end
