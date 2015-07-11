class RoomsController < ApplicationController

  before_action :ensure_admin!      # all actions
  before_action :authenticate_user! # all actions

  # Displays all the rooms on a React component.
  def index
    @rooms = Room.select("id, name").sorted
  end

  # Creates the room to database via JSON
  def create
    @room = Room.new(room_params)
    if @room.save
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # Updates the room to database via JSON
  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # Delete the room record via JSON
  def destroy
    room = Room.find(params[:id])
    room.destroy
    head :no_content
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end
end
