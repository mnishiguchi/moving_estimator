class IngredientSuggestionsController < ApplicationController

  before_action :ensure_admin!,     except: :show
  before_action :authenticate_user! # all actions

  def index
    @ingredients = IngredientSuggestion.select("id, name").sorted.to_json
  end

  def update
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.update_attributes(ingredient_suggestion_params)
    render nothing: true, status:  200
  end

  def destroy
    ingredient = IngredientSuggestion.find(params[:id])
    ingredient.destroy
    render nothing: true, status: 200
  end

  private

    def ingredient_suggestion_params
      params.require(:ingredient_suggestion).permit(:name)
    end
end
