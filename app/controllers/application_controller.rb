class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  before_action :set_current_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    # Confugure parameters Devise should accept.
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:username, :email, :password, :password_confirmation, :remember_me)
      end
      devise_parameter_sanitizer.for(:sign_in) do |u|
        u.permit(:login, :username, :email, :password, :remember_me)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:username, :email, :password, :password_confirmation, :current_password)
      end
    end


  private

    # Return true if current user is admin, else redirects to root.
    def ensure_admin!
      unless current_user.try(:admin?)
        sign_out current_user
        redirect_to root_path
        return false
      end
    end

    # Make current_user accessible in User model.
    def set_current_user
      User.current_user = current_user
    end
end
