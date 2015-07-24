class AddMoveTypeToMovings < ActiveRecord::Migration
  def change
    add_column :movings, :move_type, :string
    add_column :movings, :move_date, :date

    add_column :movings, :dwelling_sqft, :int
    add_column :movings, :dwelling_type, :string
    add_column :movings, :rooms, :string, array: true, default: []

    add_column :movings, :street_from, :string
    add_column :movings, :city_from, :string
    add_column :movings, :state_from, :string
    add_column :movings, :zip_from, :string

    add_column :movings, :street_to, :string
    add_column :movings, :city_to, :string
    add_column :movings, :state_to, :string
    add_column :movings, :zip_to, :string
  end
end
