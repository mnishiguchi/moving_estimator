class MovingsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user! # all actions
  before_action :correct_user!,     only: [:show, :edit, :update, :destroy]

  # Lists all the movings.
  def index
    @movings = current_user.movings
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
    @moving = Moving.new(moving_params.merge(user_id: current_user.id))

    if @moving.save
      unless @moving.save_rooms(params[:moving][:rooms])
        flash[:warning] = "Couldn't save rooms"
      end
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
    if @moving.update(moving_params)
      unless @moving.save_rooms(params[:moving][:rooms])
        flash[:warning] = "Couldn't save rooms"
      end
      flash[:success] = "Moving updated"
      redirect_to moving_url(@moving)
    else
      render 'edit'
    end
  end

  # Delete the moving record.
  def destroy
    @moving.destroy
    forget_moving  # Forget current moving
    flash[:success] = "Moving deleted"
    redirect_to movings_url
  end

  private

    def moving_params
      params.require(:moving).permit(:title, :description, { :room => [] },
        :move_date, :move_type, :dwelling_type, :dwelling_sqft,
        :street_from, :city_from, :state_from, :zip_from,
        :street_to, :city_to, :state_to, :zip_to)
    end

    # Rejects if a user tries to access another user’s moving.
    # Note: params[:id] is required.
    def correct_user!
      id = params[:id]
      @moving = current_user.movings.try { find_by(id: id) }
      redirect_to root_url if @moving.nil?
    end
end
