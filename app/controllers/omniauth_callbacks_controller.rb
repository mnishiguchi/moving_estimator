class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    # raise request.env["omniauth.auth"].to_yaml
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?  # Ensure that this user is saved to database.
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: __callee__) if is_navigational_format?
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url(omniauth_fail: "omniauth_fail")
    end
  end

  alias_method :twitter, :all
end
