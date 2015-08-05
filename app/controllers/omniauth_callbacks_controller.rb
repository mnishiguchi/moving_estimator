class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    ap request.env["omniauth.auth"]  #<== debugging

    profile = social_profile_from_omniauth(request.env["omniauth.auth"])
    user    = find_user_by_social_profile(profile)

    ap user  #<== debugging

    if user.persisted?  # Ensure that this user is saved to database.

      ap "yes, user persisted"  #<== debugging

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

# Look for a socialprofile based on omniauth data; if none found create one
def social_profile_from_omniauth(auth)
  raise unless auth.present?

  # Get a profile
  profile = SocialProfile.where(provider: auth['provider'], uid: auth['uid']).first
  unless profile
    profile = SocialProfile.new(provider: auth['provider'], uid: auth['uid'])
  end

  # Set omniauth data on the profile
  profile.set_omniauth_data(auth)

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

  if profile.user
    user = profile.user
  else
    user = User.create! provider: profile.provider,
                        uid:      profile.uid,
                        username: profile.name,
                        # パスワード不要なので、パスワードには触らない。
                        email: "#{SecureRandom.uuid}@example.com"
    user.skip_confirmation!
  end
  user
end


# def fix_temp_email(user)

#   ap /example/.match(user.email)

#   if /example/.match(user.email)
#     profiles = user.social_profiles
#     emails = profile.select { |p| p.email.present? && /^example/.match(p.email)}.uniq
#     user.email = emails.first
#     user.save!
#   end
