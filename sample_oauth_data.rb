# ==> Sample twitter oauth data

# Started GET "/users/auth/twitter/callback?oauth_token=M7KN3QAAAAAAg19MAAABTxd7mpo&oauth_verifier=L7SkKXttklShVqCQgGyaz6x5ZyVSQN5F" for ::1 at 2015-08-10 08:00:21 -0400
# I, [2015-08-10T08:00:21.468948 #71344]  INFO -- omniauth: (twitter) Callback phase initiated.
# Processing by OmniauthCallbacksController#twitter as HTML
#   Parameters: {"oauth_token"=>"M7KN3QAAAAAAg19MAAABTxd7mpo", "oauth_verifier"=>"L7SkKXttklShVqCQgGyaz6x5ZyVSQN5F"}
{
       "provider" => "twitter",
            "uid" => "2953088596",
           "info" => {
           "nickname" => "MNishiguchiDC",
               "name" => "Masatoshi Nishiguchi",
              "email" => nil,
           "location" => "",
              "image" => "http://pbs.twimg.com/profile_images/550274805790818305/6vTWdNYH_normal.jpeg",
        "description" => "",
               "urls" => {
            "Website" => nil,
            "Twitter" => "https://twitter.com/MNishiguchiDC"
        }
    },
    "credentials" => {
         "token" => "2953088596-OZ14yWdUSkvYj0vENlATy9XAQA6R167CpZ6QzlN",
        "secret" => "NCPsHKjOOSfYLHdXgtHrV4OeTx5eruRMQTxyXUrgwIetd"
    },
          "extra" => {
        "access_token" => #<OAuth::AccessToken:0x007f9556bea3f0 @token="2953088596-OZ14yWdUSkvYj0vENlATy9XAQA6R167CpZ6QzlN", @secret="NCPsHKjOOSfYLHdXgtHrV4OeTx5eruRMQTxyXUrgwIetd", @consumer=#<OAuth::Consumer:0x007f954c7e1588 @key="T0ONiGrNuMNsKb5AyNC05mOpe", @secret="FxrQ6ddvlVbIaUlvEm0xg4fgoK9ACmWWnkesdU60ck1vJFoBM8", @options={:signature_method=>"HMAC-SHA1", :request_token_path=>"/oauth/request_token", :authorize_path=>"/oauth/authenticate", :access_token_path=>"/oauth/access_token", :proxy=>nil, :scheme=>:header, :http_method=>:post, :oauth_version=>"1.0", :site=>"https://api.twitter.com"}, @http=#<Net::HTTP api.twitter.com:443 open=false>, @http_method=:post, @uri=#<URI::HTTPS https://api.twitter.com>>, @params={:oauth_token=>"2953088596-OZ14yWdUSkvYj0vENlATy9XAQA6R167CpZ6QzlN", "oauth_token"=>"2953088596-OZ14yWdUSkvYj0vENlATy9XAQA6R167CpZ6QzlN", :oauth_token_secret=>"NCPsHKjOOSfYLHdXgtHrV4OeTx5eruRMQTxyXUrgwIetd", "oauth_token_secret"=>"NCPsHKjOOSfYLHdXgtHrV4OeTx5eruRMQTxyXUrgwIetd", :user_id=>"2953088596", "user_id"=>"2953088596", :screen_name=>"MNishiguchiDC", "screen_name"=>"MNishiguchiDC", :x_auth_expires=>"0", "x_auth_expires"=>"0"}, @response=#<Net::HTTPOK 200 OK readbody=true>>,
            "raw_info" => {
                                            "id" => 2953088596,
                                        "id_str" => "2953088596",
                                          "name" => "Masatoshi Nishiguchi",
                                   "screen_name" => "MNishiguchiDC",
                                      "location" => "",
                                   "description" => "",
                                           "url" => nil,
                                      "entities" => {
                "description" => {
                    "urls" => []
                }
            },
                                     "protected" => false,
                               "followers_count" => 7,
                                 "friends_count" => 33,
                                  "listed_count" => 0,
                                    "created_at" => "Wed Dec 31 12:55:58 +0000 2014",
                              "favourites_count" => 3,
                                    "utc_offset" => -14400,
                                     "time_zone" => "Eastern Time (US & Canada)",
                                   "geo_enabled" => false,
                                      "verified" => false,
                                "statuses_count" => 26,
                                          "lang" => "en",
                          "contributors_enabled" => false,
                                 "is_translator" => false,
                        "is_translation_enabled" => false,
                      "profile_background_color" => "C0DEED",
                  "profile_background_image_url" => "http://abs.twimg.com/images/themes/theme1/bg.png",
            "profile_background_image_url_https" => "https://abs.twimg.com/images/themes/theme1/bg.png",
                       "profile_background_tile" => false,
                             "profile_image_url" => "http://pbs.twimg.com/profile_images/550274805790818305/6vTWdNYH_normal.jpeg",
                       "profile_image_url_https" => "https://pbs.twimg.com/profile_images/550274805790818305/6vTWdNYH_normal.jpeg",
                            "profile_link_color" => "0084B4",
                  "profile_sidebar_border_color" => "C0DEED",
                    "profile_sidebar_fill_color" => "DDEEF6",
                            "profile_text_color" => "333333",
                  "profile_use_background_image" => true,
                          "has_extended_profile" => false,
                               "default_profile" => true,
                         "default_profile_image" => false,
                                     "following" => false,
                           "follow_request_sent" => false,
                                 "notifications" => false
        }
    }
}

# ==> Sample facebook oauth data

# I, [2015-08-10T08:02:41.638448 #71344]  INFO -- omniauth: (facebook) Callback phase initiated.
# Processing by OmniauthCallbacksController#facebook as HTML
#   Parameters: {"code"=>"AQCIepubSA0DOqvOKCThdG9KhkBf6gX6M0fMRMulnOKLWq3aANxcIsbAIy1rnu0_LAqKGZHw3Sn8I5Tcn2GMFDc70FlJPrfU24-XTvrKS7j10G4MrX-VssiDSNVEoj9rIY814j8CuQVL29G72Dv_DM0iiORJfWk0KXdtMNxfZTdC6Sp4RbrvXJHeyMlXV79x6no0S6jWD4sdGX_uG9-tZJcBicRSNITWN-Uvp7M9gAbH875PNWnOPXOqH_RHVdAEkBrgNs2HYujcF5Fsr-H6JjEclyWA2gPQkVMTOgnbBHDZSeioFonQ6rRnRyX9kEpP1HKkTjVa5ebvdFOUPxyE1vjr", "state"=>"0c31212467a5e9c22527df869b33da981f0f67b611ff207e"}
{
       "provider" => "facebook",
            "uid" => "129842044022762",
           "info" => {
         "name" => "Masatoshi Nishiguchi",
        "image" => "http://graph.facebook.com/129842044022762/picture"
    },
    "credentials" => {
             "token" => "CAAGqJEhiMpcBABhpPlEE0UcG5GIAdcwwRqUjozuFPkMyCjdg75TZCDHRh0SMtZAVN8OPaNp6gQOnCj1wRpt64nkZAbLROuTDTC9ZApqWZCSHeZAq63ZCXJdfKja4e2ZCuu5rf8IF090SWzKkYGzZCXubkwCE9q2p40othhtZA6KYDe4UeUYOyMxQqT2kQWBvXiNEMVUQ9K2ct2LSKx8oKDWSQz",
        "expires_at" => 1444334872,
           "expires" => true
    },
          "extra" => {
        "raw_info" => {
            "name" => "Masatoshi Nishiguchi",
              "id" => "129842044022762"
        }
    }
}
