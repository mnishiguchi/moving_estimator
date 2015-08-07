class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_current_user

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
