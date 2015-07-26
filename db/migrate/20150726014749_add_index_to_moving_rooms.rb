class AddIndexToMovingRooms < ActiveRecord::Migration
  def change
    add_index :moving_rooms, :moving_id
    add_index :moving_rooms, :room_id
    add_index :moving_rooms, [:moving_id, :room_id], unique: true
  end
end
