require 'rails_helper'

RSpec.describe 'UsersIndices', type: :request do
  describe 'GET /users_indices' do
    let(:user) { create(:user) }
    it 'shows the first page' do
      log_in_as(user)
      get users_path
      expect(response).to have_http_status(200)
      User.paginate(page: 1).each do |user|
        expect(response.body).to include(user.name)
        expect(response.body).to include(user_path(user))
      end
    end
  end

  describe 'deleteing users' do
    let(:user) { create(:user) }
    let(:admin) { create(:user, name: 'Jane', email: 'JDoe@email.com', admin: true) }
    before 'each' do
      user
      admin
    end
    context 'user is not allowed to delete' do
      it 'should not delete for non admin user' do
        log_in_as user
        expect { delete "#{users_path}/#{user.id}", id: user.id }.to_not change { User.all.count }
        expect(response).to redirect_to root_url
      end
      it 'should redirect destroy when not logged in' do
        expect { delete "#{users_path}/#{user.id}" }.to_not change { User.all.count }
        expect(response).to redirect_to login_url
      end
      it 'does not show the delete buttons for non admin' do
        allow(self).to receive(:document_root_element) { html_document.root }
        log_in_as user
        get users_path
        assert_select 'a', text: 'delete', count: 0
      end
    end
    context 'admin logged in' do
      it 'should allow admin to delete users' do
        log_in_as admin
        get users_path
        expect { delete "#{users_path}/#{user.id}", id: user.id }.to change { User.all.count }.by(-1)
      end
      it 'should not show a delete button for the admin user' do
        allow(self).to receive(:document_root_element) { html_document.root }
        log_in_as admin
        get users_path
        assert_select 'a', text: 'delete', count: 1
      end
    end
  end
end
