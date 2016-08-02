require 'rails_helper'

RSpec.describe "UsersIndices", type: :request do
  describe "GET /users_indices" do
    let(:user) { create(:user) }
    it "works! (now write some real specs)" do
      log_in_as(user)
      get users_path
      expect(response).to have_http_status(200)
      User.paginate(page: 1).each do |user|
        expect(response.body).to include(user.name)
        expect(response.body).to include(user_path user)
      end
    end
  end
end
