class MovingItemsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user! # all actions
  before_action :ensure_moving!     # all actions

  # Note: A list of items is displayed in Movings#show page instead of MovingItems#index.

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
    @moving_item = MovingItem.find(params[:id])
  end

  # Updates the item to database.
  def update
    @moving_item = MovingItem.find(params[:id])
    @moving_item.update_columns(moving_item_params)
    flash[:success] = "Item updated"
    redirect_to moving_url(@moving)
  end

  # Delete the moving item record.
  def destroy
    MovingItem.find(params[:id]).destroy
    flash[:success] = "Item deleted"
    moving = Moving.find(current_moving)
    redirect_to moving_url(moving)
  end

  private

    def moving_item_params
      params.require(:moving_item).permit(:name, :volume, :quantity,
                                          :description, :room, :category)
    end

    # Ensures that current moving actually exists in database.
    def ensure_moving!
      @moving = Moving.find(current_moving)
    end
end
