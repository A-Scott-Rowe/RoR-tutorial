require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE #destroy' do
    it 'removes the user and returns redirect' do
      allow(controller).to receive(:logged_in?) { true }
      allow(controller).to receive(:log_out)
      expect(controller).to receive(:log_out)
      delete :destroy
      expect(response).to have_http_status(:redirect)
    end
  end
end
