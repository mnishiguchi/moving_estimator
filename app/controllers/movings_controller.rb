class MovingsController < ApplicationController

  before_action :authenticate_user! # all actions

  # Lists all the movings.
  def index
    @movings = Moving.all
  end

  # Shows an individual item.
  def show
    @moving = Moving.find(params[:id])
    @moving_items = @moving.moving_items
  end

  # Shows a form to create a new moving.
  def new
    @moving = Moving.new
    # @moving.categories = nil
    # @moving.rooms = nil
  end

  # Creates a new moving based on the form.
  def create
    @moving = Moving.new(moving_params)
    @moving.categories = params[:moving][:categories].split(/\s/)
    @moving.rooms      = params[:moving][:rooms].split(/\s/)

    if @moving.save
      flash[:success] = "Moving created"
      redirect_to moving_url(@moving)
    else
      render 'new'
    end
  end

  # Shows a add-item form.
  def edit
  end

  # Updates the moving to database.
  def update
  end

  # Delete the moving record.
  def destroy
  end

  private

    def moving_params
      params.require(:moving).permit(:user_id, :title, :description, :categories, :rooms)
    end
end
