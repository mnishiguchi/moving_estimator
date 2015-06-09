window.loadIngredientSuggestionsEditor = (options) ->

  # Constants (Action types)

  constants =
    UPDATE_INGREDIENT: "UPDATE_INGREDIENT"
    DELETE_INGREDIENT: "DELETE_INGREDIENT"

  # Stores

  IngredientSuggestionsStore = Fluxxor.createStore
    initialize: ->

      @ingredients = options || []
      # console.log @ingredients  # Debug

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
        $('div#message-container').messenger().post "Ingredient suggestion updated"
      .fail (jqXHR, textStatus, errorThrown) =>
        console.error textStatus, errorThrown.toString()
        $('div#message-container').messenger().post "Error updating ingredient suggestion"

    deleteIngredient: (ingredient) ->
      @dispatch(constants.DELETE_INGREDIENT, ingredient: ingredient)
      $.ajax
        method: "DELETE"
        url: "/ingredient_suggestions/" + ingredient.id

      .done (data, extStatus, jqXHR) ->
        $('div#message-container').messenger().post "Ingredient suggestion deleted"
      .fail (jqXHR, textStatus, errorThrown) =>
        console.error textStatus, errorThrown.toString()
        $('div#message-container').messenger().post "Error deleting ingredient suggestion"

  # Instantiating our stores

  stores =
    IngredientSuggestionsStore: new IngredientSuggestionsStore

  # Creating a Flux instance with our stores and actions that are defined above

  flux = new Fluxxor.Flux(stores, actions)

  # Logging upon the "dispatch" event

  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?


  # The main React component (<IngredientSuggestionsEditor/>)

  FluxMixin = Fluxxor.FluxMixin(React)
  StoreWatchMixin = Fluxxor.StoreWatchMixin

  @IngredientSuggestionsEditor = React.createClass
    mixins: [FluxMixin, StoreWatchMixin("IngredientSuggestionsStore")]

    # getInitialState: ->
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


  # The sub-component <IngredientSuggestion/>

  IngredientSuggestion = React.createClass
    mixins: [FluxMixin]

    getInitialState: ->
      changed: false
      updated: false

    render: ->

      buttons =
        <span>
          <a href="#" onClick={@handleUpdate}>Update</a>
          <a href="#" onClick={@handleCancelChange}>Cancel</a>
        </span>

      <div>
        <a href="#" onClick={@handleDelete}>
          <i className="fa fa-times"></i>
        </a>
        <input onChange={@handleChange}
               ref="ingredient"
               defaultValue={@props.ingredient.name}/>

        { buttons if @state.changed? }
      </div>

    handleChange: ->
      input = $(@refs.ingredient.getDOMNode()).val()
      if input isnt @props.ingredient.name
      then @setState(changed: true)
      else @setState(changed: false)

    handleUpdate: (e) ->
      e.preventDefault()
      input = $(@refs.ingredient.getDOMNode()).val()
      @getFlux().actions.updateIngredient(@props.ingredient, input)
      @setState(changed: false, updated: true)

    handleDelete: (e) ->
      e.preventDefault()
      if confirm("Delete " + @props.ingredient.name + "?")
        @getFlux().actions.deleteIngredient(@props.ingredient)

    handleCancelChange: (e) ->
      e.preventDefault()
      $(@refs.ingredient.getDOMNode()).val(@props.ingredient.name)  # Restore the original value
      @setState(changed: false)

  # Rendering the whole component to the target element

  target = document.getElementById("IngredientSuggestionsEditor")
  if target
  then React.render <IngredientSuggestionsEditor flux={flux}/>, target
  else console.log("Couldn't find the target element")

