Fluxxor.todosFlux = (options) ->

  # Constants (Action types)

  constants =
    FETCH_TODOS: 'FETCH_TODOS'
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

      @bindActions(constants.FETCH_TODOS, @onFetchTodos,
                   constants.ADD_TODO,    @onAddTodo,
                   constants.TOGGLE_TODO, @onToggleTodo,
                   constants.UPDATE_TODO, @onUpdateTodo,
                   constants.DELETE_TODO, @onDeleteTodo)

    getState: ->
      todos: @todos

    onFetchTodos: (payload) ->
      @emit('change')

    onAddTodo: (payload) ->
      #       id = @_nextTodoId()
      # todo =
      #   id:       id
      #   text:     payload.text
      #   complete: false
      # @todos[id] = todo
      @emit('change')

    onToggleTodo: (payload) ->
      id = payload.id
      @todos[id].completed = not @todos[id].completed
      @emit('change')

    onUpdateTodo: (payload) ->
      @emit('change')

    onDeleteTodo: (payload) ->
      id = payload.todo.id
      @todos.remove(id)
      @emit('change')

  # Registering our semantic actions

  actions =
    fetchTodos: (data)->
      @dispatch(constants.FETCH_TODOS, data: data)
      console.log "[fetchTodos: (data)]"
      $.ajax
        url: "/todos/"
        dataType: 'json'
        data: data
      .done (data, textStatus, jqXHR) ->
        console.log data
        @setState
          todos: data
        $.growl.notice title: "", message: "Todos reloaded"
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "Error", message: "Error fetching todos"
        console.error textStatus, errorThrown.toString()

    addTodo:    (content) ->
      @dispatch(constants.ADD_TODO, content: content)

      params = todo:
                 content: content
      $.ajax
        method: "POST"
        url: "/todos/"
        data: params
      .done (data, textStatus, jqXHR) ->
        $.growl.notice title: "", message: "Todo added"
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "Error", message: "Error adding todo"
        console.error textStatus, errorThrown.toString()

    toggleTodo: (id, completed)   ->
      @dispatch(constants.TOGGLE_TODO, id: id, completed: completed)

      params = todo:
                 id:        id
                 completed: completed
      $.ajax
        method: "PATCH"
        url: "/todos/" + id
        data: params
      .done (data, textStatus, jqXHR) ->
        message = if params.todo.completed then "Completed" else "Not completed"
        $.growl.notice title: "", message: message
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "Error", message: "Error toggleing todo completion"
        console.error textStatus, errorThrown.toString()

    updateTodo: (todo, new_content) ->
      @dispatch(constants.UPDATE_TODO, todo:        todo,
                                       new_content: new_content)

      params = todo:
                 id:        todo.id
                 content:   new_content
                 completed: todo.completed
      $.ajax
        method: "PATCH"
        url: "/todos/" + todo.id
        data: params
      .done (data, textStatus, jqXHR) ->
        $.growl.notice title: "", message: "Todo updated"
      .fail (jqXHR, textStatus, errorThrown) ->
        $.growl.error title: "Error", message: "Error updating todo"
        console.error textStatus, errorThrown.toString()

    deleteTodo: (todo) ->
      @dispatch(constants.DELETE_TODO, todo: todo)

      params = todo:
                 id: todo.id
      $.ajax
        method: "DELETE"
        url: "/todos/" + todo.id
        data: params
      .done (data, textStatus, jqXHR) ->
        $.growl.notice title: "Deleted", message: todo.content
      .fail (jqXHR, textStatus, errorThrown) ->
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
