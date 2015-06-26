class CreateMovings < ActiveRecord::Migration
  def change
    create_table :movings do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.text :categories, array: true, default: []
      t.text :rooms,      array: true, default: []

      t.timestamps null: false
    end
  end
end
