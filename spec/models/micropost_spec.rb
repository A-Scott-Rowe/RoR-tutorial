require 'rails_helper'

RSpec.describe Micropost, type: :model do
  describe 'create a micropost' do
    let(:user) { create(:user) }
    let(:micropost) { user.microposts.build(content: 'This is some content') }
    context 'micropost requires a user id' do
      it 'should be valid' do
        expect(micropost.valid?).to be true
      end

      it 'requires a user id' do
        micropost.user_id = nil
        expect(micropost.valid?).to_not be true
      end
    end
    context 'content length is 140 chars' do
      it 'should not be longer than 140 characters' do
        micropost.content = 'a' * 141
        expect(micropost.valid?).to be false
      end

      it 'should not be empty' do
        micropost.content = '            '
        expect(micropost.valid?).to be false
      end
    end
  end

  describe 'microposts should be in descending chrono order' do
    let(:micropost) { create(:micropost, user_id: 1) }
    it 'should be the first post' do
      micropost
      expect(micropost).to eq Micropost.first
    end
  end
end
