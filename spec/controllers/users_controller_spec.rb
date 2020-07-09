require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe UsersController do 
  describe "GET #index" do 
    context 'with correct authorization header' do
      before do 
        user = User.create(
          name: 'Name',
          phone: '1234567890',
          password: '123456')
        headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
        # This will add a valid token for `user` in the `Authorization` header
        auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
        auth_headers.each do |k, v|
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