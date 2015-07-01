class MovingsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user! # all actions
  before_action :set_moving,        only: [:show, :edit, :update]
  before_action :set_volume_data,   only: :show

  # Lists all the movings.
  def index
    @movings = Moving.all
  end

  # Shows an individual item.
  def show
    @moving_items = @moving.moving_items
    @moving_item = MovingItem.new  # For new form
    remember_moving @moving        # Remember moving id for later use.
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
  end

  # Updates the moving to database.
  def update
    @moving.update_columns(moving_params)
    flash[:success] = "Moving updated"
    redirect_to moving_url(@moving)
  end

  # Delete the moving record.
  def destroy
    Moving.find(params[:id]).destroy
    forget_moving  # Forget current moving
    flash[:success] = "Moving deleted"
    redirect_to movings_url
  end

  private

    def moving_params
      params.require(:moving).permit(:title, :description)
    end

    def set_moving
      id = params[:id] || current_moving
      @moving = Moving.find(id)
    end

    def set_volume_data
      @vol_by_category = @moving.moving_items.group(:category).sum(:volume)
      @vol_by_room     = @moving.moving_items.group(:room).sum(:volume)
    end
end
