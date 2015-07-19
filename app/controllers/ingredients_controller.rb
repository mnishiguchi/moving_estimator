class IngredientsController < ApplicationController

  before_action :ensure_admin!,     except: :show
  before_action :authenticate_user! # all actions

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.create(ingredient_params)
      flash[:notice] = "Ingredient created"
      redirect_to ingredients_url
    else
      render 'new'
    end
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  def update
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.update(ingredient_params)
      flash[:notice] = "Ingredient updated"
      redirect_to ingredients_url
    else
      render 'edit'
    end
  end

  def destroy
    ingredient = Ingredient.find(params[:id])
    ingredient.destroy
    flash[:notice] = "Ingredient deleted"
    redirect_to ingredients_url
  end

  private

    def ingredient_params
      params.require(:ingredient).permit(:name, :volume)
    end
end
