# Initializes the Flux

Fluxxor.initTodosFlux = (options) ->

  # Constants (Action types)

  constants =
    ADD_TODO:    'ADD_TODO'
    TOGGLE_TODO: 'TOGGLE_TODO'
    UPDATE_TODO: 'UPDATE_TODO'
    DELETE_TODO: 'DELETE_TODO'

  # Stores

  TodoStore = Fluxxor.createStore
    initialize: ->
      @todos = {}
      if options.hasOwnProperty("todos")
        for todo in options["todos"]
          @todos[todo.id] = todo

      @bindActions(constants.ADD_TODO,    @onAddTodo,
                   constants.TOGGLE_TODO, @onToggleTodo,
                   constants.UPDATE_TODO, @onUpdateTodo,
                   constants.DELETE_TODO, @onDeleteTodo)

    getState: ->
      todos: @todos

    onAddTodo: (payload) ->
      # Update UI
      new_todo = payload.new_todo
      @todos[new_todo.id] = new_todo
      @emit('change')

    onToggleTodo: (payload) ->
      # Update UI
      @todos[payload.id].completed = payload.completed
      @emit('change')

    onUpdateTodo: (payload) ->
      # Update UI
      @todos[payload.id].content = payload.new_content
      @emit('change')

    onDeleteTodo: (payload) ->
      # Update UI
      delete @todos[payload.id]
      @emit('change')

  # Registering our semantic actions

  actions =

    # Creates a new todo to database. Dispatches ADD_TODO on successful Ajax.
    addTodo:    (content) ->
      params = todo:
                 content: content
      $.ajax
        method: "POST"
        url: "/todos/"
        data: params
      .done (data, textStatus, jqXHR) =>
        new_todo =
          id:        data.id
          content:   data.content
          completed: data.completed
        @dispatch(constants.ADD_TODO, new_todo: new_todo)
        $.growl.notice title: "", message: "Todo added"
      .fail (jqXHR, textStatus, errorThrown) =>
        $.growl.error title: "Error", message: "Error adding todo"
        console.error textStatus, errorThrown.toString()

    # Saves a new completion status to database. Dispatches TOGGLE_TODO on successful Ajax.
    toggleTodo: (id, completed) ->
      params = todo:
                 completed: completed
      $.ajax
        method: "PATCH"
        url: "/todos/" + id
        data: params
      .done (data, textStatus, jqXHR) =>
        title = if data.completed then "Completed" else "Not completed"
        @dispatch(constants.TOGGLE_TODO, id: data.id, completed: data.completed)
        $.growl.notice title: title, message: data.content
      .fail (jqXHR, textStatus, errorThrown) =>
        $.growl.error title: "Error", message: "Error toggleing todo completion"
        console.error textStatus, errorThrown.toString()

    # Saves a new content to database. Dispatches UPDATE_TODO on successful Ajax.
    updateTodo: (id, new_content) ->
      params = todo:
                 content: new_content
      $.ajax
        method: "PATCH"
        url: "/todos/" + id
        data: params
      .done (data, textStatus, jqXHR) =>
        @dispatch(constants.UPDATE_TODO, id: data.id, new_content: data.content)
        $.growl.notice title: "", message: "Todo updated"
      .fail (jqXHR, textStatus, errorThrown) =>
        $.growl.error title: "Error", message: "Error updating todo"
        console.error textStatus, errorThrown.toString()

    # Deletes a todo to database. Dispatches DELETE_TODO on successful Ajax.
    deleteTodo: (id) ->
      $.ajax
        method: "DELETE"
        url: "/todos/" + id
      .done (data, textStatus, jqXHR) =>
        @dispatch(constants.DELETE_TODO, id: data.id)
        $.growl.notice title: "Deleted", message: data.content
      .fail (jqXHR, textStatus, errorThrown) =>
        $.growl.error title: "Error", message: "Error deleting todos"
        console.error textStatus, errorThrown.toString()

  # Instantiating our stores

  stores =
    TodoStore: new TodoStore

  # Creating a Flux instance with our stores and actions that are defined above

  flux = new Fluxxor.Flux(stores, actions)

  # Logging upon the "dispatch" event

  flux.on 'dispatch', (type, payload) ->
    console.log "[Dispatch]", type, payload if console?.log?

  return flux
