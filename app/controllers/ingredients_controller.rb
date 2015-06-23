class IngredientsController < ApplicationController

  before_action :ensure_admin!,     except: :show
  before_action :authenticate_user! # all actions

  def index
    @ingredients = Ingredient.select("id, name").sorted.to_json
  end

  def update
    ingredient = Ingredient.find(params[:id])
    ingredient.update_attributes(ingredient_params)
    render nothing: true, status:  200
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    render nothing: true, status: 200
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
