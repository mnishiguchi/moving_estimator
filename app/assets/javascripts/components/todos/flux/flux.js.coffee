@todolistFlux ||= {}

# Constants (Action types)

@todolistFlux["constants"] =
  ADD_TODO:    'ADD_TODO'
  TOGGLE_TODO: 'TOGGLE_TODO'
  UPDATE_TODO: 'UPDATE_TODO'
  DELETE_TODO: 'DELETE_TODO'
  FILTER_ALL:       'FILTER_ALL'
  FILTER_COMPLETED: 'FILTER_COMPLETED'
  FILTER_NOT_DONE:  'FILTER_NOT_DONE'

# Initializer

@todolistFlux["init"] = (options) ->

  # Instantiates the stores
  stores =
    TodoStore: new todolistFlux.stores.TodoStore(options["todos"])

  # Instantiates the flux with the stores and actions
  flux = new Fluxxor.Flux(stores, todolistFlux.actions)

  # Logging for the "dispatch" event
  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  return flux
