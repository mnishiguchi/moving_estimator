class UsersController < ApplicationController

  before_action :ensure_admin!,     except: :show
  before_action :authenticate_user! # all actions

  # A list of all users (for admin only)
  def index
    @users = User.all.paginate(page: params[:page])

    # For exporting csv
    respond_to do |format|
      format.html
      format.csv { send_data @users.unscoped.to_csv,
                             filename: "users-#{Date.today}.csv" }
    end
  end

  # Each user's dashboard
  def show
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    # Returns true if current user is admin, else redirects to root.
    def ensure_admin!
      unless current_user.try(:admin?)
        sign_out current_user
        redirect_to root_path
        return false
      end
    end
end
