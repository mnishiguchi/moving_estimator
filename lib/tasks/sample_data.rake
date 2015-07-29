require './app/helpers/ingredients_helper.rb'
include IngredientsHelper

namespace :db do
  desc "Fill ingredients table with sample data"
  task populate_ingredients: :environment do
    make_ingredients(living_room)
    make_ingredients(kitchen)
    make_ingredients(bedroom)
    make_ingredients(dining_room)
    make_ingredients(outdoor)
    make_ingredients(office)
  end
end

def make_ingredients(household_goods)
  household_goods.each { |name, volume| Ingredient.create!(name: name, volume: volume) }
end
