require 'rails_helper'

RSpec.describe 'UsersEdits', type: :request do
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'
    post login_path, session: { email:       user.email,
                                password:    password,
                                remember_me: remember_me }
  end

  describe 'PUT /users_edits' do
    let(:user) { create(:user) }
    let(:user1) { create(:user, name: 'Jane', email: 'JDoe@email.com') }
    it 'cannot update with invalid parameters' do
      get edit_user_path user
      log_in_as user
      expect(response).to redirect_to edit_user_path(user)
      expect(response).to have_http_status(:redirect)
      patch user_path(user), user: { name: '',
                                     email: 'not@right',
                                     password: 'foo',
                                     password_confirmation: 'bar' }
      expect(response).to render_template('users/edit')
    end

    it 'should update with valid parameters' do
      log_in_as user
      get edit_user_path user
      expect(response).to have_http_status(200)
      expect(response).to render_template('users/edit')
      patch user_path(user), user: { name: 'Scott Doe',
                                     email: 'avalid@email.com',
                                     password: '',
                                     password_confirmation: '' }
      expect(response).to redirect_to(user)
      user.reload
      expect(user.name).to eq 'Scott Doe'
      expect(user.email).to eq 'avalid@email.com'
    end

    it 'should not let anonymous users edit' do
      get edit_user_path user
      expect(flash).to_not be_empty
      expect(response).to redirect_to login_url
    end

    it 'should not let anonymous users update' do
      patch user_path(user), user: { name: user.name, email: user.email }
      expect(flash).to_not be_empty
      expect(response).to redirect_to login_url
    end

    it 'should not let users edit others info' do
      log_in_as user1
      get edit_user_path user
      expect(flash).to be_empty
      expect(response).to redirect_to root_url
    end

    it 'should not let users update others info' do
      log_in_as user1
      patch user_path(user), user: { name: user.name, email: user.email }
      expect(flash).to be_empty
      expect(response).to redirect_to root_url
    end
  end
end
