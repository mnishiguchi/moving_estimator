IngredientStore     = require('./stores/ingredient_store')
IngredientActions   = require('./actions/ingredient_actions')
IngredientEditorApp = require('./components/IngredientEditorApp')

# Instantiates the flux with data passed in from Rails.

instantiateFlux = (options) ->

  # Instantiates the stores
  stores =
    IngredientStore: new IngredientStore(options["ingredients"])

  # Actions
  actions = IngredientActions

  # Instantiates the flux with the stores and actions
  flux = new Fluxxor.Flux(stores, actions)

  # Logging for the "dispatch" event
  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  return flux

# Invoked in a Rails template with JSON data passed in.

React._initIngredientEditorApp = (options) ->

  # Instantiates the flux.
  flux = instantiateFlux(options)

  # Rendering the whole component to the mount node
  if (mountNode = document.getElementById("react_ingredient_editor"))
    React.render <IngredientEditorApp flux={ flux } />, mountNode
