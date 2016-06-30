require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StaticPagesHelper. For example:
#
# describe StaticPagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
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
