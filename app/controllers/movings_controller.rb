class MovingsController < ApplicationController

  before_action :authenticate_user! # all actions

  def index
    @movings = Moving.all
  end

  def show
    @moving = Moving.find(params[:id])
    @moving_items = @moving.moving_items
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def moving_params
      params.require(:moving).permit(:user_id, :title, :description, :categories, :rooms)
    end
end
