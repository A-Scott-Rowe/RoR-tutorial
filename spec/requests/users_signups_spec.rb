require 'rails_helper'

RSpec.describe 'UsersSignups', type: :request do
  describe 'GET /users_signups' do
    it 'works! (now write some real specs)' do
      get signup_path
      expect(response).to have_http_status(200)
      user_hash = { name: 'Test Guy', email: 'not@a.eamil', password: 'password', password_confirmation: 'password' }
      expect { post users_path, user: user_hash }.to change { User.count }
      expect(session[:user_id]).to_not be_nil
    end

    it 'does not make a new user with invalid info' do
      get signup_path
      user_hash = { name: '', email: 'not@a.eamil', password: 'foo', password_confirmation: 'bar' }
      expect { post users_path, user: user_hash }.to_not change { User.count }
      expect(response).to render_template('users/new')
    end
  end
end
