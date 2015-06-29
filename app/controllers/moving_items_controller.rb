class MovingItemsController < ApplicationController

  # Shows a form to create a new item.
  def new
    # @moving_id = # TODO - get moving_id
    @new_item = MovingItem.new
  end

  def create
    moving = Moving.find(params[:moving_item][:moving_id])
    moving_item = MovingItem.new(moving_item_params)

    if moving_item.save
      flash[:success] = "Moving item created"
      redirect_to moving_url(moving)
    else
      render 'movings/show'
    end
  end

  def update
  end

  def destroy
  end

  private

    def moving_item_params
      params.require(:moving_item).permit(:moving_id, :name, :volume, :quantity,
                                          :description, :room, :category)
    end
end
