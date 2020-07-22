require 'devise/jwt/test_helpers'
module AuthHelpers
  def configure_auth_headers(user)
    headers = { 'Accept' => 'application/json' }
        # This will add a valid token for `user` in the `Authorization` header
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end