class IngredientSuggestionsController < ApplicationController

  def index
    @ingredients = IngredientSuggestion.select("id, name").sorted.to_json
  end

  def update
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.update_attribute(:name, params[:name])
    render nothing: true, status:  200
  end

  def destroy
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.destroy
    render nothing: true, status: 200
  end
end
