class RenameIngredientSuggestionsToIngredients < ActiveRecord::Migration
  def change
    rename_table :ingredient_suggestions, :ingredients
  end
end
