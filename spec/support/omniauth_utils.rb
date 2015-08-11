# https://github.com/intridea/omniauth/wiki/Integration-Testing

def set_omniauth
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
    "provider" => "twitter",
    "uid"  => "mock_uid_1234",
    "info" => {
      "name"  => "Mock User",
      "image" => "http://mock_image_url.com"
    },
    "credentials" => {
       "token"  => "mock_credentials_token",
       "secret" => "mock_credentials_secret"
    },
    "extra" => {
      "raw_info" => {
        "name" => "Mock User",
        "id"   => "mock_uid_1234"
      }
    }
  })
end

def set_invalid_omniauth
  OmniAuth.config.mock_auth[:twitter] = :invalid_credentials
end
