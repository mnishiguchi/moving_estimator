class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    # raise request.env["omniauth.auth"].to_yaml  # For debugging

    # user = User.from_omniauth(request.env["omniauth.auth"])

    profile = social_profile_from_omniauth(request.env["omniauth.auth"])
    user    = find_user_by_social_profile(profile)

    ap user  #<== debugging

    if user.persisted?  # Ensure that this user is saved to database.

      ap "yes, user persisted"  #<== debugging

      sign_in_and_redirect user
      set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?
    else

      ap "no, user not persisted"  #<== debugging

      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :twitter, :all
end

# Look for a socialprofile based on omniauth data; if none found create one
def social_profile_from_omniauth(auth)
  raise unless auth.present?

  # Get a profile
  profile = SocialProfile.where(provider: auth['provider'], uid: auth['uid']).first
  unless profile
    profile = SocialProfile.new(provider: auth['provider'], uid: auth['uid'])
  end

  # Set omniauth data on the profile
  profile.set_values(auth)

  # Look for corresponding user if not already registered
  unless profile.user_id
    user = User.where(provider: profile.provider, uid: profile.uid).try(:first)
    profile.user_id = user.id if user
  end
  profile
end

# Look for a user who belongs to this profile; if none found, create one
def find_user_by_social_profile(profile)
  raise unless profile.present?

  return profile.user if profile.user

  user = User.new(provider: profile.provider,
           uid:      profile.uid,
           username: profile.name)
           # パスワード不要なので、パスワードには触らない。
           # email: "#{SecureRandom.uuid}@example.com"
  user
end
