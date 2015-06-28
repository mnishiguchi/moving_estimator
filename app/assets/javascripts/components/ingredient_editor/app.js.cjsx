IngredientStore     = require('./stores/ingredient_store')
IngredientActions   = require('./actions/ingredient_actions')
IngredientEditorApp = require('./components/IngredientEditorApp')

# Invoked in a Rails template with JSON data passed in.

React._initIngredientEditorApp = (mountNode, options) ->

  # Instantiates the stores
  stores =
    IngredientStore: new IngredientStore(options["ingredients"] if options)

  # Actions
  actions = IngredientActions

  # Instantiates the flux with the stores and actions
  flux = new Fluxxor.Flux(stores, actions)

  # Logging for the "dispatch" event
  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  # Renders the whole component to the mount node.
  # Checks if mount node exists to suppress error caused by loading irrelevant pages.
  if(m = document.getElementById(mountNode))
    React.render(<IngredientEditorApp flux={ flux } />, m)
