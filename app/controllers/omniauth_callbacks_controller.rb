class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    ap request.env["omniauth.auth"]  #<== debugging

    profile = social_profile_from_omniauth(request.env["omniauth.auth"])
    user    = find_user_by_social_profile(profile)

    ap profile  #<== debugging
    ap user     #<== debugging

    if user.persisted?  # Ensure that this user is saved to database.
      ap "yes, user persisted"  #<== debugging

      # Update profile with user data
      profile.update_columns(user_id: user.id, email: user.email)

      sign_in_and_redirect user
      set_flash_message(:notice, :success, kind: __callee__.to_s.capitalize) if is_navigational_format?

    else  # 何らかの理由でデータベースに保存されていない。
      ap "no, user NOT persisted"  #<== debugging

      session["devise.user_attributes"] = user.attributes  # 認証データを覚えておく。
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :twitter, :all
end

# Look for a socialprofile based on omniauth data; if not found create one
def social_profile_from_omniauth(auth)
  raise unless auth.present?

  # Get a profile
  profile = SocialProfile.where(provider: auth['provider'], uid: auth['uid']).first
  unless profile
    profile = SocialProfile.create!(provider: auth['provider'], uid: auth['uid'])
  end

  # Set omniauth data on the profile
  profile.set_omniauth_data(auth)

  # Set corresponding user id if not already registered
  unless profile.user_id.present?
    user = User.where(provider: profile.provider, uid: profile.uid).try(:first)
    profile.user_id = user.id if user
  end
  return profile
end

# Look for a user who belongs to this profile; if user not found, create a new one.
def find_user_by_social_profile(profile)
  raise unless profile.present?

  # 1. Try to find user by profile
  return profile.user if profile.user

  # 2. Try to find user by profile email;
  user = User.find_by(email: profile.email) if profile.email.present?

  # 3. if user not found, create a new one.
  unless user
    email = if profile.email.present? then profile.email
                                      else "#{SecureRandom.uuid}@example.com"
                                      end
    user = User.create! provider: profile.provider,
                        uid:      profile.uid,
                        username: profile.name,
                        email:    email
                        # Let's leave password alone.
    # Update profile's email
    profile.update_columns(email: user.email)

    ap "User created"   #<== debugging
  end
  # No need for email confirmation because we use omniauth.
  user.skip_confirmation!
  return user
end
