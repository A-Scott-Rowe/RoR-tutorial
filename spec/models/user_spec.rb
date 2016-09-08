require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(name: 'Example User',
             email: 'eaxample@email.com',
             password: 'foobar',
             password_confirmation: 'foobar')
  end

  describe 'user validity' do
    it 'should be valid' do
      expect(user).to be_valid
    end

    it 'should not be valid without a username' do
      user.name = '     '
      expect(user).to_not be_valid
    end

    it 'should not be valid without an email' do
      user.email = '   '
      expect(user).to_not be_valid
    end

    it 'should not be valid if the name is too long' do
      user.name = 'a' * 51
      expect(user).to_not be_valid
    end

    it 'should not be valid if the email is too long' do
      user.email = 'a' * 254 + '@exampe.com'
      expect(user).to_not be_valid
    end

    it 'should accept valid email addresses' do
      %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn).each do |address|
        user.email = address
        expect(user).to be_valid
      end
    end

    it 'should not accept invalid email addresses' do
      %w(user@example,com user_at_foo.org user.name@example.
         foo@bar_baz.com foo@bar+baz.com foo@bar..com).each do |address|
        user.email = address
        expect(user).to_not be_valid
      end
    end

    it 'should have a unique email' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      expect(duplicate_user).to_not be_valid
    end

    it 'should have a lowercase password' do
      upper_email = 'THISIS@ANUPER.EMAIL'
      user.email = upper_email
      user.save
      expect(user.reload.email).to eq(upper_email.downcase)
    end

    context 'should have a strong password' do
      it 'will not accept shot passwords' do
        user.password = user.password_confirmation = 'a' * 5
        expect(user).to_not be_valid
      end
      it 'will not accept blank passwords' do
        user.password = user.password_confirmation = ' ' * 5
        expect(user).to_not be_valid
      end
    end
  end

  describe 'user microposts' do
    let(:user) { create :user }

    it 'deletes all user microposts when user is deleted' do
      user.microposts.create! content: 'test'
      expect { user.destroy }.to change { Micropost.count }.by(-1)
    end
  end

  describe 'user follows another user' do
    let(:user) { create(:user) }
    let(:user1) { create(:user, name: 'Jane', email: 'JDoe@email.com') }
    it 'should follow and unfollow a user' do
      expect(user.following?(user1)).to_not be true
      user.follow(user1)
      expect(user.following?(user1)).to be true
      user.unfollow user1
      expect(user.following?(user1)).to_not be true
    end
  end
end
