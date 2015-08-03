class UsersController < ApplicationController

  before_action :ensure_admin!,     except: :show
  before_action :authenticate_user! # all actions
  before_action :search_users,      only: :index

  # A list of all users and csv export(for admin only)
  def index
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def search_users
      @users =  if params[:search].present?
        then User.search(params[:search])
        else User.all
        end.sorted.paginate(page: params[:page])
    end
end
