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

    ap __method__.to_s + " was invoked"                #<== debugging
    ap "email_verified?: #{resource.email_verified?}"  #<== debugging
    ap resource.errors.any?


    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
