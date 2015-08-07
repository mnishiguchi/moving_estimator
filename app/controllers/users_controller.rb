class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :finish_signup]
  before_action :ensure_admin!,      except: :finish_signup
  before_action :authenticate_user!, except: :finish_signup

  # A list of all users and csv export
  def index
    search_users
  end

  # GET   /users/:id/finish_signup
  # PATCH /users/:id/finish_signup
  def finish_signup
    if request.patch?
      if @user.update(user_params)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    @user.destroy
    redirect_to root_url, notice: "User deleted"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :username, :email ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    end

    def search_users
      @search = SearchForm.new(params[:search_form])
      @users =  if @search.q.present?
        then User.search(@search.q)
        else User.all
        end.sorted.paginate(page: params[:page])
    end
end
