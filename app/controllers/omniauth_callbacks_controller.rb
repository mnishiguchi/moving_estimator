class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def callback_for_all_providers
    # ap request.env["omniauth.auth"]  #<== debugging

    @user = find_user_for_oauth(env["omniauth.auth"])

    if @user.persisted?  # Ensure that this user is saved to database.
      # If user's email is already confirmed, then log in the user.
      # Otherwise enforce email confirmation
      if @user.email_verified?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?
      else
        @user.reset_confirmation!
        flash[:warning] = "We need your email address before proceeding."
        redirect_to finish_signup_path(@user)
      end
    else  # 何らかの理由でデータベースに保存されていない。
      flash[:denger] = "Something went wrong!"
      puts "user is not persisted"  # <== DEBUG
      session["devise.user_attributes"] = @user.attributes  # 認証データを覚えておく。
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :callback_for_all_providers
  alias_method :twitter,  :callback_for_all_providers


  def find_user_for_oauth(auth)

    # Get a profile for omniauth
    profile = SocialProfile.find_for_oauth(auth)

    # First try to find current_user or profile.user
    user = current_user ? current_user : profile.user

    if user.nil?
      # Query for user if verified email is provided
      user = User.where(email: email).first if verified_email_from_oauth(auth)
      user ||= find_or_create_new_user(auth)
    end
    associate_user_with_profile!(user, profile)
    user
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
        provider: "See social profiles",
        uid:      "See social profiles",
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
