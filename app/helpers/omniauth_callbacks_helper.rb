module OmniauthCallbacksHelper

  class GetOAuthUser

    def self.call(auth)
      # Get a profile for omniauth
      profile = SocialProfile.find_for_oauth(auth)
      # First try to find current user or profile user
      user = current_or_profile_user(profile)
      unless user
        # Query for user if verified email is provided
        user = User.where(email: email).first if verified_email_from_oauth(auth)
        # If user was not found, create one based on oauth data
        user ||= find_or_create_new_user(auth)
      end
      associate_user_with_profile!(user, profile)
      user
    end

    private
      class << self

        def current_or_profile_user(profile)
          user = User.current_user.presence || profile.user
        end

        def find_or_create_new_user(auth)
          # Query for user if verified email is provided
          email = verified_email_from_oauth(auth)
          user = User.where(email: email).first if email

          # Create a new user if user not found
          if user.nil?
            temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
            user = User.new(
              username: auth.extra.raw_info.name,
              email:    email ? email : temp_email,
              password: Devise.friendly_token[0,20]
            )
            user.skip_confirmation!     # Temporarily disable confirmation
            user.save(validate: false)  # Temporarily disable validation
            user
          end
        end

        def verified_email_from_oauth(auth)
          auth.info.email if auth.info.email && (auth.info.verified || auth.info.verified_email)
        end

        # Associate the profile with the user if needed
        def associate_user_with_profile!(user, profile)
          profile.update!(user_id: user.id) if profile.user != user
        end
      end
  end

  class FacebookOAuthPolicy
    attr_reader :provider, :uid, :name, :nickname, :email, :url, :image_url,
                :description, :other, :credentials, :raw_info

    def initialize(auth = {})
      @provider    = auth["provider"]
      @uid         = auth["uid"]
      @name        = auth["info"]["name"]
      @nickname    = ""
      @email       = ""
      @url         = ""
      @image_url   = auth["info"]["image"]
      @description = ""
      @credentials = auth["credentials"].to_json
      @raw_info    = auth["extra"]["raw_info"].to_json
      freeze
    end
  end

  class TwitterOAuthPolicy
    attr_reader :provider, :uid, :name, :nickname, :email, :url, :image_url,
                :description, :other, :credentials, :raw_info

    def initialize(auth = {})
      @provider    = auth["provider"]
      @uid         = auth["uid"]
      @name        = auth["info"]["name"]
      @nickname    = ""
      @email       = ""
      @url         = ""
      @image_url   = auth["info"]["image"]
      @description = auth["info"]["description"].try(:truncate, 255)
      @credentials = auth["credentials"].to_json
      @raw_info    = auth["extra"]["raw_info"].to_json
      freeze
    end
  end
end
