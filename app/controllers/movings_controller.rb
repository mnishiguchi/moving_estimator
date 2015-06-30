class MovingsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user! # all actions

  # Lists all the movings.
  def index
    @movings = Moving.all
  end

  # Shows an individual item.
  def show
    id = params[:id] || current_moving
    @moving = Moving.find(id)
    @moving_items = @moving.moving_items
    @moving_item = MovingItem.new  # For new form
    remember_moving @moving          # Remember moving id for later use.
  end

  # Shows a form to create a new moving.
  def new
    @moving = Moving.new
  end

  # Creates a new moving based on the form.
  def create
    @moving = Moving.new(moving_params.
                         merge(user_id: current_user.id))

    if @moving.save
      flash[:success] = "Moving created"
      redirect_to moving_url(@moving)
    else
      render 'new'
    end
  end

  # Shows an edit-item form.
  def edit
    @moving = Moving.find(params[:id])
  end

  # Updates the moving to database.
  def update
    @moving = Moving.find(params[:id])
    @moving.update_columns(moving_params)
    flash[:success] = "Moving updated"
    redirect_to moving_url(@moving)
  end

  # Delete the moving record.
  def destroy
    Moving.find(params[:id]).destroy
    forget_moving
    flash[:success] = "Moving deleted"
    redirect_to movings_url
  end

  private

    def moving_params
      params.require(:moving).permit(:title, :description)
    end
end
