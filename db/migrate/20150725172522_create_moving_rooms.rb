class CreateMovingRooms < ActiveRecord::Migration
  def change
    create_table :moving_rooms do |t|
      t.integer :moving_id
      t.integer :room_id

      t.timestamps null: false
    end
  end
end
