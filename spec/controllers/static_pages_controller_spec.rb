require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  render_views

  BASE_TITLE = 'Ruby on Rails Tutorial Sample App'.freeze

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
      assert_select 'title', BASE_TITLE.to_s
    end
  end

  describe 'GET #help' do
    it 'returns http success' do
      get :help
      expect(response).to have_http_status(:success)
      assert_select 'title', "Help | #{BASE_TITLE}"
    end
  end

  describe 'GET #about' do
    it 'returns http success' do
      get :about
      expect(response). to have_http_status(:success)
      assert_select 'title', "About | #{BASE_TITLE}"
    end
  end

  describe 'GET #contact' do
    it 'returns http success' do
      get :contact
      expect(response).to have_http_status(:success)
      assert_select 'title', "Contact | #{BASE_TITLE}"
    end
  end
end
