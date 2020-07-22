require 'rails_helper'
require_relative '../support/auth_helpers.rb'

RSpec.configure do |c|
  c.include AuthHelpers
end

RSpec.describe UsersController do 
  describe "GET #index" do 
    context 'with correct authorization header' do
      before do 
        user = User.all.first
        headers = configure_auth_headers(user)
        # set headers, note that setting headers in controller
        # is different than request spec
        headers.each do |k, v|
          request.headers[k] = v
        end
        get :index
      end

      it 'returns http success' do 
        expect(response).to have_http_status(:success)
      end

      it "responds with expected user attributes" do
        json_response = JSON.parse(response.body)
        expected = {
          "id" => kind_of(Integer),
          'name' => kind_of(String),
          'phone' => kind_of(String),
          'created_at' => kind_of(String),
          'updated_at' => kind_of(String),
          'email' => kind_of(String),
          'user_overall_balance' => kind_of(Integer),
          'user_group_balance' => kind_of(Hash)
        }
        expect(json_response).to match(expected)
      end
    end
    context 'with incorrect authorization header' do
      it 'returns http error' do 
        get :index
        expect(response.body).to include('You need to sign in or sign up before continuing.')
      end
    end
  end
end