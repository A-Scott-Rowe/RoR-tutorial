require 'rails_helper'

RSpec.describe "SiteLayouts", type: :request do
    
    it "Get root dir" do
      get root_path
      expect(response).to have_http_status(200)
      expect(response).to render_template('static_pages/home')
    end
  
end
