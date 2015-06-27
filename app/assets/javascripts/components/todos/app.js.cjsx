TodoStore   = require('./stores/todo_store')
TodoActions = require('./actions/todo_actions')
TodoApp     = require('./components/TodoApp')

# Invoked in a Rails template with JSON data passed in.

React._initTodoApp = (mountNode, options) ->

  # Instantiates the stores
  stores =
    TodoStore: new TodoStore(options["todos"] if options)

  # Actions
  actions = TodoActions

  # Instantiates the flux with the stores and actions
  flux = new Fluxxor.Flux(stores, actions)

  # Logging for the "dispatch" event
  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  # Rendering the whole component to the mount node
  React.render(<TodoApp flux={ flux } />, document.getElementById(mountNode))
