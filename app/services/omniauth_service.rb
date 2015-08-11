class ProcessOmniAuthCallback

  # TODO: Implement OmniAuthService to refactor OmniAuth-related logic

  def initialize(auth)
    @auth = auth
  end

  def find_user_for_omniauth(auth)

    # Get a profile for omniauth
    profile = SocialProfile.find_for_omniauth(auth)

    # First try to find current_user or profile.user
    user = current_user ? current_user : profile.user

    if user.nil?
      # Query for user if verified email is provided
      email = verified_email_from_omniauth(auth)
      user = User.where(email: email).first if email

      # Create a new user if it's a new registration
      if user.nil?
        user = User.new(
          username: auth.extra.raw_info.name,
          email:    email ? email : "#{User::TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          provider: "See social profiles",
          uid:      "See social profiles",
          password: Devise.friendly_token[0,20]
        )
        user.skip_confirmation!  # Temporarily disable confirmation
        user.save!
      end
    end
    associate_user_with_profile!(user, profile)
    user
  end

  def create_new_user
  end


  def verified_email_from_omniauth(auth)
    auth.info.email if auth.info.email && (auth.info.verified || auth.info.verified_email)
  end

  # Associate the profile with the user if needed
  def associate_user_with_profile!(user, profile)
    if profile.user != user
      profile.user = user
      profile.save!
    end
  end
end
