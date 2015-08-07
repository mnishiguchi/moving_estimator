class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def callback_for_all_providers
    ap request.env["omniauth.auth"]  #<== debugging

    @user = User.find_for_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?  # Ensure that this user is saved to database.
      ap "yes, user persisted"  #<== debugging

      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?
    else  # 何らかの理由でデータベースに保存されていない。
      ap "no, user NOT persisted"  #<== debugging

      session["devise.user_attributes"] = user.attributes  # 認証データを覚えておく。
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :callback_for_all_providers
  alias_method :twitter,  :callback_for_all_providers

  def after_sign_in_path_for(resource)

    ap __method__.to_s + " was invoked"  #<== debugging
    ap "email_verified?: #{resource.email_verified?}"  #<== debugging

    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end

# # Look for a socialprofile based on omniauth data; if not found create one.
# def social_profile_from_omniauth(auth)
#   raise unless auth.present?

#   # Get a profile based on provider and uid.
#   data = { provider: auth['provider'], uid: auth['uid'] }
#   profile = SocialProfile.where(data).first_or_create(data)

#   # Set omniauth data on the profile.
#   profile.set_oauth_data(auth)

#   # Set corresponding user id if not already registered.
#   unless profile.user_id.present?
#     user = User.where(provider: profile.provider, uid: profile.uid).try(:first)
#     profile.user_id = user.id if user
#   end
#   return profile
# end

# # Look for a user who belongs to this profile; if user not found, create a new one.
# def find_user_by_social_profile(profile)
#   raise unless profile.present?

#   # 1. Try to find user by profile.
#   return profile.user if profile.user

#   # 2. Try to find user by profile email.
#   user = User.find_by(email: profile.email) if profile.email.present?

#   # 3. if user not found, create a new one.
#   unless user
#     email = if profile.email.present?
#             then profile.email
#             else "#{SecureRandom.uuid}@example.com" end

#     user = User.create! provider: profile.provider,
#                         uid:      profile.uid,
#                         username: profile.name,
#                         email:    email
#                         # Let's leave password alone.

#     # Update profile's email.
#     profile.update_columns(email: user.email)

#     ap "User created"   #<== debugging
#   end
#   # No need for email confirmation because we use omniauth.
#   user.skip_confirmation!
#   return user
# end

