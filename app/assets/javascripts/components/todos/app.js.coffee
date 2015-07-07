TodoStore   = require('./stores/todo_store')
TodoActions = require('./actions/todo_actions')
TodoApp     = require('./components/TodoApp')

# Invoked in a Rails template with JSON data passed in.

React._initTodoApp = (mountNode, options) ->

  # Instantiating the stores.
  stores =
    TodoStore: new TodoStore(options["todos"] if options)

  # Actions
  actions = TodoActions

  # Instantiating the flux with the stores and actions.
  flux = new Fluxxor.Flux(stores, actions)

  # Logging for the "dispatch" event.
  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  # Rendering the whole component to the mount node.
  # Checking if mount node exists to suppress error caused by loading irrelevant pages.
  if(m = document.getElementById(mountNode))
    React.render(<TodoApp flux={ flux } />, m)
