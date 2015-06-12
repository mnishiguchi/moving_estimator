window.loadTodoList = (options) ->

  # Constants (Action types)

  constants =
    ADD_TODO:    'ADD_TODO'
    TOGGLE_TODO: 'TOGGLE_TODO'
    UPDATE_TODO: 'UPDATE_TODO'
    CLEAR_TODOS: 'CLEAR_TODOS'

  # Stores

  TodoStore = Fluxxor.createStore
    initialize: ->
      @todos = options || []
      console.log @todos  # debug
      @bindActions(constants.ADD_TODO,    @onAddTodo,
                   constants.TOGGLE_TODO, @onToggleTodo,
                   constants.UPDATE_TODO, @onUpdateTodo,
                   constants.CLEAR_TODOS, @onClearTodos)

    getState: ->
      todos: @todos

    onAddTodo: (payload) ->
      @emit('change')

    onToggleTodo: (payload) ->
      @emit('change')

    onUpdateTodo: (payload) ->
      @emit('change')

    onClearTodos: (payload) ->
      @emit('change')

  # Registering our semantic actions

  actions =
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

    toggleTodo: (todo, toggled_completion)   ->
      @dispatch(constants.TOGGLE_TODO, todo: todo,
                                       toggled_completion: toggled_completion)

      params = todo:
                 id:        todo.id
                 completed: toggled_completion
      $.ajax
        method: "PATCH"
        url: "/todos/" + todo.id
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

    clearTodos: (completed_todos) ->
      @dispatch(constants.CLEAR_TODOS)

      # Deleting each after double-checking the completion status.
      for todo in completed_todos when todo.completed
        params = todo:
                   id: todo.id
        $.ajax
          method: "DELETE"
          url: "/ingredient_suggestions/" + todo.id
          data: params

        .done (data, extStatus, jqXHR) ->
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

  # The main React component (<TodoList/>)

  @TodoList = React.createClass
    mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("TodoStore")]

    # getInitialState: ->
    #   new_todo_text: ""

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    render: ->
      todos = @state.todos

      <div className="well">
        <TodoNavigation todo={todos}
                        flux={flux} />
        {
          for todo in todos
            <Todo todo={todo}
                  key={todo.id}
                  flux={flux} />
        }
      </div>

  # Rendering the whole component to the target element

  if (target = document.getElementById("react_todolist"))
    React.render <TodoList flux={flux} />, target
