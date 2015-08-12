class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniauthCallbacksHelper

  def callback_for_all_providers
    # ap request.env["omniauth.auth"]  #<== debugging

    unless env["omniauth.auth"].present?
      flash[:danger] = "Authentication failed"
      redirect_to root_url and return
    end

    provider = __callee__.to_s
    @user = GetOAuthUser.call(env["omniauth.auth"])

    if @user.persisted? && @user.email_verified?
      # Ensure that this user is saved to database.
      # If user's email is already confirmed, then log in the user.
      # Otherwise enforce email confirmation
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else  # 何らかの理由でデータベースに保存されていない。
      @user.reset_confirmation!
      flash[:warning] = "We need your email address before proceeding."
      redirect_to finish_signup_path(@user)

      # session["devise.user_attributes"] = @user.attributes  # 認証データを覚えておく。
      # redirect_to new_user_registration_url
    end
  end
  alias_method :facebook, :callback_for_all_providers
  alias_method :twitter,  :callback_for_all_providers
end
