require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET #index' do
    it 'should not be viewable when not logged in' do
      get :index
      expect(response).to redirect_to login_url
    end
  end

  describe 'relationships' do
    let(:user) { create(:user) }
    it 'should redirect following when not logged in' do
      get :following, id: user
      expect(response).to redirect_to login_url
    end
    it 'should redirect followers when not logged in' do
      get :followers, id: user
      expect(response).to redirect_to login_url
    end
  end
end
