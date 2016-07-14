require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'just base title' do
    it 'returns the base title when empty' do
      expect(helper.full_title('')).to eq('Ruby on Rails Tutorial Sample App')
    end
  end

  describe 'custom title' do
    it 'returns a custom title when properites' do
      expect(helper.full_title('Title')).to eq('Title | Ruby on Rails Tutorial Sample App')
    end
  end
end
