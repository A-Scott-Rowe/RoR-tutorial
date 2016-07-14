require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    post login_path, session: { email:       user.email,
                                password:    password,
                                remember_me: remember_me }
  end
  describe "GET /users_logins" do
    it "invalid user can't login" do
      get login_path
      expect(response).to have_http_status(200)
      expect(response).to render_template('sessions/new')
      post login_path, session: { email: "", password: "" }
      expect(response).to render_template('sessions/new')
      expect(flash).to_not be_empty
      get root_path
      expect(flash).to be_empty
    end
  end

  describe 'user logs in' do
    let(:user) { create(:user) }
    it 'allows the user to log in' do
      get login_path
      log_in_as user
      expect(response).to redirect_to(user)
    end

    it 'will set the remember token if prompted' do
      get login_path
      log_in_as user, remember_me: '1'
      expect(cookies['remember_token']).to_not be_nil
    end

    it 'will not set the remember toke if not remembered' do
      get login_path
      log_in_as user, remember_me: '0'
      expect(cookies['remember_token']).to be_nil
    end
  end
end
