class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :finish_signup]
  before_action :ensure_admin!,      except: :finish_signup
  before_action :authenticate_user!, except: :finish_signup

  # A list of all users and csv export
  def index
    search_users
  end

  # # GET /users/:id/edit
  # def edit
  #   # authorize! :update, @user
  # end

  # # PATCH/PUT /users/:id.:format
  # def update
  #   # authorize! :update, @user
  #   if @user.update(user_params)
  #     sign_in(@user == current_user ? @user : current_user, bypass: true)
  #     redirect_to root_url, notice: 'Your profile was successfully updated.'
  #   else
  #     render action: 'edit'
  #   end
  # end

  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, bypass: true)
        redirect_to root_url, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    @user.destroy
    redirect_to root_url, notice: "User deleted"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      accessible = [ :name, :email ] # extend with your own params
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
