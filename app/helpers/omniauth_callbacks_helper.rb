module OmniauthCallbacksHelper



  def find_user_for_oauth(auth)
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

  def current_or_profile_user(profile)
    if current_user then current_user else profile.user end
  end

  def find_or_create_new_user(auth)
    # Query for user if verified email is provided
    email = verified_email_from_oauth(auth)
    user = User.where(email: email).first if email

    # Create a new user if it's a new registration
    if user.nil?
      temp_email = "#{User::TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com"
      user = User.new(
        username: auth.extra.raw_info.name,
        email:    email ? email : temp_email,
        password: Devise.friendly_token[0,20]
      )
      user.skip_confirmation!  # Temporarily disable confirmation
      user.save
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
