class MovingItemsController < ApplicationController
  include MovingsHelper

  before_action :authenticate_user!  # all actions
  before_action :current_moving!     # all actions
  before_action :correct_user!, only: [:edit, :update, :destroy]
  after_action  :update_rooms,  only: [:create, :update]

  # Export csv file
  def index
    @moving_items = @moving.moving_items
  end

  def new
    @moving_item = MovingItem.new  # For new form
    @suggestions = @moving.autocomplete_suggestions  # For AutoComplete
  end

  # Create the item to database via JSON
  def create
    @moving_item = MovingItem.new(moving_item_params.
                                  merge(moving_id: current_moving))
    if @moving_item.save
      flash[:success] = "Create #{@moving_item.name}"
      redirect_to @moving
    else
      @suggestions = @moving.autocomplete_suggestions  # For AutoComplete
      render "new"
    end
  end

  def edit
  end

  def update
    if @moving_item.update(moving_item_params)
      flash[:success] = "Updated #{@moving_item.name}"
      redirect_to @moving
    else
      @suggestions = @moving.autocomplete_suggestions  # For AutoComplete
      render "edit"
    end
  end

  def destroy
    if @moving_item.destroy
      flash[:success] = "Deleted #{@moving_item.name}"
    else
      flash[:danger] = "Couldn't delete #{@moving_item.name}"
    end
    redirect_to @moving
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

    # Adds a room name to database if it is new.
    def update_rooms
      Room.find_or_create_by(name: @moving_item.room)
    end
end
