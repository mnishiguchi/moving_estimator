class CreateMovingCategories < ActiveRecord::Migration
  def change
    create_table :moving_categories do |t|
      t.string :name
      t.references :moving, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
