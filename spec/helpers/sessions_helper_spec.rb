require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  describe 'user authentication' do
    let(:user) { instance_double('user', id: 12_345) }
    it 'will allow the user to log in' do
      expect { log_in(user) }.to change { session[:user_id] }
    end
    it 'will allow user to logout' do
      @current_user = build(:user)
      allow(@current_user).to receive(:forget) { true }
      session[:user_id] = 'sdgfdsggsdgdg44g'
      expect { log_out }.to change { session[:user_id] }
      expect(@current_user).to be_nil
    end
  end
end
