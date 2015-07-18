@IngredientStore = Fluxxor.createStore

  initialize: (ingredients) ->
    @ingredients = {}
    if ingredients
      for ingredient in ingredients
        @ingredients[ingredient.id] = ingredient
    @bindActions(IngredientConstants.UPDATE_INGREDIENT, @onUpdateIngredient,
                 IngredientConstants.DELETE_INGREDIENT, @onDeleteIngredient)

  getState: ->
    ingredients: @ingredients

  onUpdateIngredient: (payload) ->
    @ingredients[payload.id].new_name = payload.new_name
    @emit('change')

  onDeleteIngredient: (payload) ->
    delete @ingredients[payload.id]
    @emit('change')
