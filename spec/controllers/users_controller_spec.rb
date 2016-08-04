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
  describe 'User deletion' do
    let(:user) { create(:user) }
    let(:user1) { create(:user, name: 'Jane', email: 'JDoe@email.com') }
    it 'should redirect destroy when not logged in' do
      expect {delete :destroy, id: user.id}.to_not change {User.all.count}
    end
    it 'should not delete for non admin user' do
      user1.save
      user.save
      log_in_as user
      expect {delete :destroy, id: user.id}.to_not change {User.all.count}
    end
  end
end
