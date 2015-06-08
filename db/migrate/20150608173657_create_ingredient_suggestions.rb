class CreateIngredientSuggestions < ActiveRecord::Migration
  def change
    create_table :ingredient_suggestions do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
