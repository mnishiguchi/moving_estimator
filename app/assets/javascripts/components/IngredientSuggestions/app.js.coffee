window.loadIngredientSuggestionsEditor = (options) ->

  # Constants (Action types)

  constants =
    UPDATE_INGREDIENT: "UPDATE_INGREDIENT"
    DELETE_INGREDIENT: "DELETE_INGREDIENT"

  # Stores

  IngredientSuggestionsStore = Fluxxor.createStore
    initialize: ->
      @ingredients = options || []
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

  # Registering our semantic actions

  actions =
    updateIngredient: (ingredient, new_name) ->
      @dispatch(constants.UPDATE_INGREDIENT, ingredient: ingredient,
                                             new_name:   new_name)
      $.ajax
        method: "PATCH"
        url: "/ingredient_suggestions/" + ingredient.id
        data:
          name: new_name

      .done (data, textStatus, jqXHR) ->
        $.growl.notice title: "", message: "Ingredient suggestion updated"
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "", message: "Error updating ingredient suggestion"
        console.error textStatus, errorThrown.toString()

    deleteIngredient: (ingredient) ->
      @dispatch(constants.DELETE_INGREDIENT, ingredient: ingredient)
      $.ajax
        method: "DELETE"
        url: "/ingredient_suggestions/" + ingredient.id

      .done (data, extStatus, jqXHR) ->
        $.growl.notice title: "", message: "Ingredient suggestion deleted"
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "", message: "Error deleting ingredient suggestion"
        console.error textStatus, errorThrown.toString()

  # Instantiating our stores

  stores =
    IngredientSuggestionsStore: new IngredientSuggestionsStore

  # Creating a Flux instance with our stores and actions that are defined above

  flux = new Fluxxor.Flux(stores, actions)

  # Logging upon the "dispatch" event

  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  # The main React component (<IngredientSuggestionsEditor/>)

  @IngredientSuggestionsEditor = React.createClass
    mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("IngredientSuggestionsStore")]

    # getInitialState: -> # none

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('IngredientSuggestionsStore').getState()

    render: ->

      ingredients = @state.ingredients.map (ingredient) ->
        <IngredientSuggestion ingredient={ingredient}
                              key={ingredient.id}
                              flux={flux} />
      <div>
        {ingredients}
      </div>

  # Rendering the whole component to the target element

  target = document.getElementById("IngredientSuggestionsEditor")
  if target
  then React.render <IngredientSuggestionsEditor flux={flux}/>, target
  else console.error("Couldn't find the target element")
