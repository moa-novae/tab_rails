require 'rails_helper'
require_relative '../support/auth_helpers.rb'

RSpec.configure do |c|
  c.include AuthHelpers
end

RSpec.describe "add new group", type: :request do 
  context 'with correct authorization header' do
    before do
      user = User.all.first
      headers = configure_auth_headers(user)
      params = {
        group: {
          name: 'default',
          description: 'default text'
        },
        members: [user.id]
      }
      post "/api/groups", params: params, headers: headers
    end
    it "returns 201 and location header" do 
      expect(response).to have_http_status(:created)
      expect(response.header['Location']).to eq("/api/groups/#{Group.last.id}")
    end
  end
end