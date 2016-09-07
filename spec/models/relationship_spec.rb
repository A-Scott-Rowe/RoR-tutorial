require 'rails_helper'

RSpec.describe Relationship, type: :model do
  describe 'relationship validity' do
    let(:relationship) do
      Relationship.new follower_id: 1, followed_id: 2
    end

    it 'should be valid' do
      expect(relationship).to be_valid
    end

    it 'should require a follower_id' do
      relationship.follower_id = nil
      expect(relationship).to_not be_valid
    end

    it 'should require followed_id' do
      relationship.followed_id = nil
      expect(relationship).to_not be_valid
    end
  end
end
