@todolistFlux ||= {}

# Stores

@todolistFlux["stores"] =

  TodoStore: Fluxxor.createStore
    initialize: (todos) ->
      @todos = {}
      @completedItems = []
      if todos
        for todo in todos
          @todos[todo.id] = todo
          @completedItems.push(todo.id) if todo.completed

      @bindActions(todolistFlux.constants.ADD_TODO,    @onAddTodo,
                   todolistFlux.constants.TOGGLE_TODO, @onToggleTodo,
                   todolistFlux.constants.UPDATE_TODO, @onUpdateTodo,
                   todolistFlux.constants.DELETE_TODO, @onDeleteTodo
                   todolistFlux.constants.FILTER_ALL,       @onFilterAll
                   todolistFlux.constants.FILTER_COMPLETED, @onFilterCompleted
                   todolistFlux.constants.FILTER_NOT_DONE,  @onFilterNotDone )

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

    onFilterAll: (payload) ->
      # Update UI
      @emit('change')

    onFilterCompleted: (payload) ->
      # Update UI
      @emit('change')

    onFilterNotDone: (payload) ->
      # Update UI
      @emit('change')
