constants = require('../constants/ingredient_constants')

IngredientStore = Fluxxor.createStore

  initialize: (ingredients) ->
    @ingredients = ingredients || []
    @bindActions(constants.UPDATE_INGREDIENT, @onUpdateIngredient,
                 constants.DELETE_INGREDIENT, @onDeleteIngredient)

  getState: ->
    ingredients: @ingredients

  onUpdateIngredient: (payload) ->
    payload.ingredient.name = payload.new_name
    @emit('change')

  onDeleteIngredient: (payload) ->
    @ingredients = @ingredients.filter (ingredient) ->
      ingredient.id isnt payload.ingredient.id
    @emit('change')

module.exports = IngredientStore
