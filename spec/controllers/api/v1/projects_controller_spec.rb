require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do
  let(:user) { FactoryBot.create :user }

  describe 'GET #index' do
    context 'unauthorized User' do
      it 'returns HTTP Status 401' do
        get :index
        expect(response).to have_http_status 401
      end
    end

    context 'authorized User' do
      it 'returns collections of Projects', :show_in_doc do
        request.headers.merge!(user.create_new_auth_token)
        projects = FactoryBot.create_list(:project, 5, user_id: user.id)
        get :index
        expect(json.size).to eq(projects.size)
      end
    end
  end
end
