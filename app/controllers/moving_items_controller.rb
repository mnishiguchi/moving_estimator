class MovingItemsController < ApplicationController

  include MovingsHelper

  before_action :authenticate_user!  # all actions
  before_action :current_moving!     # all actions
  before_action :correct_user!, only: [:edit, :update, :destroy]

  # Note: A list of items is displayed in Movings#show page.

  # Creates the item to database via JSON
  def create
    @moving_item = MovingItem.new(moving_item_params.
                                  merge(moving_id: current_moving))
    if @moving_item.save
      # update_rooms_and_categories
      render json: @moving_item
    else
      render json: @moving_item.errors, status: :unprocessable_entity
    end
  end

  # Updates the item to database via JSON
  def update
    if @moving_item.update(moving_item_params)
      # update_rooms_and_categories
      render json: @moving_item
    else
      render json: @moving_item.errors, status: :unprocessable_entity
    end
  end

  # Delete the moving item record via JSON
  def destroy
    if @moving_item.destroy
      # update_rooms_and_categories
      render json: @moving_item
    else
      render json: @moving_item.errors, status: :unprocessable_entity
    end
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

    # def update_rooms_and_categories
    #   @moving.moving_categories.find_or_create_by_name(@moving_item.category)
    #   Room.find_or_create_by_name(@moving_item.room)
    # end
end
