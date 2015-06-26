class CreateMovingItems < ActiveRecord::Migration
  def change
    create_table :moving_items do |t|
      t.references :moving, index: true, foreign_key: true
      t.string :name
      t.float :vol
      t.integer :quantity
      t.text :description
      t.text :room
      t.text :category

      t.timestamps null: false
    end
  end
end
