class RoomsController < ApplicationController

  before_action :ensure_admin!      # all actions
  before_action :authenticate_user! # all actions

  # Displays all the rooms on a React component.
  def index
    @rooms = Room.select("id, name").sorted
  end

  # An HTML form to create a new room
  def new
    @room = Room.new
  end

  # Creates the room to database on HTML form
  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_path
    else
      render "new"
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
    @room = Room.find(params[:id])
    if @room.destroy
      render json: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  private

    def room_params
      params.require(:room).permit(:name)
    end
end
