require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  
  render_views

  BASE_TITLE = 'Ruby on Rails Tutorial Sample App'.freeze
  
  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
      response.body.should include(BASE_TITLE)
    end
  end

  describe 'GET #help' do
    it 'returns http success' do
      get :help
      expect(response).to have_http_status(:success)
      response.body.should include("Help | #{BASE_TITLE}")
    end
  end

  describe 'GET #about' do
    it 'returns http success' do
      get :about
      expect(response). to have_http_status(:success)
      response.body.should include("About | #{BASE_TITLE}")
    end
  end
end
