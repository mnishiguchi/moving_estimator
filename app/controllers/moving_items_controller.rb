class MovingItemsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user!  # all actions
  before_action :current_moving!     # all actions
  before_action :correct_user!, only: [:edit, :update, :destroy]

  # Note: A list of items is displayed in Movings#show page.

  # Shows a form to create a new item.
  def new
    @moving_item = MovingItem.new
  end

  def create
    @moving_item = MovingItem.new(moving_item_params.
                                  merge(moving_id: current_moving))

    if @moving_item.save
      flash[:success] = "Moving item created"
      moving = Moving.find(current_moving)
      redirect_to moving_url(moving)
    else
      @movings = current_user.movings
      @moving_items = @moving.moving_items
      render 'movings/show'
    end
  end

  # Shows an edit form.
  def edit
  end

  # Updates the item to database.
  def update
    @moving_item.update_columns(moving_item_params)
    flash[:success] = "Item updated"
    redirect_to moving_url(@moving)
  end

  # Delete the moving item record.
  def destroy
    # MovingItem.find(params[:id]).destroy
    @moving_item.destroy
    flash[:success] = "Item deleted"
    moving = Moving.find(current_moving)
    redirect_to moving_url(moving)
  end

  private

    def moving_item_params
      params.require(:moving_item).permit(:name, :volume, :quantity,
                                          :description, :room, :category)
    end

    # Ensures that current moving is set. If true, fetches data from database.
    # Note: current_moving is stored in the sessison variable.
    def current_moving!
      @moving = Moving.find_by(id: current_moving) if try(:current_moving)
      redirect_to root_url if @moving.nil?
    end

    # Rejects if a user tries to access another user’s moving_items.
    # Note: params[:id] is required.
    def correct_user!
      id = params[:id]
      @moving_item = current_user.moving_items.try { find_by(id: id) }
      redirect_to root_url if @moving_item.nil?
    end
end
