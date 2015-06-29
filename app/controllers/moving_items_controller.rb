class MovingItemsController < ApplicationController

  include MovingsHelper

  # Shows a form to create a new item.
  def new
    @moving_item = MovingItem.new
    @moving_id = current_moving
  end

  def create
    @moving_item = MovingItem.new(moving_item_params.
                                  merge(moving_id: current_moving))

    if @moving_item.save
      flash[:success] = "Moving item created"
      moving = Moving.find(current_moving)
      redirect_to moving_url(moving)
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private

    def moving_item_params
      params.require(:moving_item).permit(:name, :volume, :quantity,
                                          :description, :room, :category)
    end
end
