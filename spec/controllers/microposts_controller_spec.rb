require 'rails_helper'

# RSpec.configure do |c|
#   c.infer_base_class_for_anonymous_controllers = false
# end

RSpec.describe MicropostsController, type: :controller do
  describe 'Micropost actions' do
    it 'should redirect create if not logged in' do
      expect { post :create, micropost: { content: 'Lorem ipsum' } }.to_not change { Micropost.count }
      expect(response).to redirect_to login_url
    end

    it 'should redirect create if not logged in' do
      micro = create(:micropost, user_id: 1)
      micro.save
      expect { delete :destroy, id: micro }.to_not change { Micropost.count }
      expect(response).to redirect_to login_url
    end
    context 'deleting microposts' do
      let(:user) { create :user }
      let(:micropost) { create :micropost, user_id: 2 }
      it 'should not let you delete others microposts' do
        user.save
        # allow().to receive(:current_user) {user}
        log_in_as user
        expect(delete(:destroy, id: micropost)).to_not change { Micropost.count }
        expect(response).to redirect_to root_url
      end
    end
  end
end
