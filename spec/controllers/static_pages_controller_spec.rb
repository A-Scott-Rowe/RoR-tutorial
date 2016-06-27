require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  
  render_views

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
      response.body.should include('Home | Ruby on Rails Tutorial Sample App')
    end
  end

  describe 'GET #help' do
    it 'returns http success' do
      get :help
      expect(response).to have_http_status(:success)
      response.body.should include('Help | Ruby on Rails Tutorial Sample App')
    end
  end

  describe 'GET #about' do
    it 'returns http success' do
      get :about
      expect(response). to have_http_status(:success)
      response.body.should include('About | Ruby on Rails Tutorial Sample App')
    end
  end
end
