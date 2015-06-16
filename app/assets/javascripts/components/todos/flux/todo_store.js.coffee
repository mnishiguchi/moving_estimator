@todolistFlux ||= {}

# Stores

@todolistFlux["stores"] =

  TodoStore: Fluxxor.createStore
    initialize: (todos) ->
      @todos = {}
      @idsCompleted = []
      @idsNotDone = []
      if todos
        for todo in todos
          @todos[todo.id] = todo
          # if todo.completed then @idsCompleted.push(todo.id) else @idsNotDone.push(todo.id)

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
      for todo in @allTodos
        @idsCompleted = []
        @idsNotDone = []
        if todo.completed then @idsCompleted.push(todo.id) else @idsNotDone.push(todo.id)

    onUpdateTodo: (payload) ->
      # Update UI
      @todos[payload.id].content = payload.new_content
      @emit('change')

    onDeleteTodo: (payload) ->
      # Update UI
      delete @todos[payload.id]
      @emit('change')

    onFilterAll: ->
      # Update UI
      # @todos = @allTodos
      # @emit('change')

    onFilterCompleted: ->
      # Update UI
      # @todos = {}
      # @todos[id] = @allTodos[id] for id in @idsCompleted
      # @emit('change')

    onFilterNotDone: ->
      # Update UI
      # @todos = {}
      # @todos[id] = @allTodos[id] for id in @idsNotDone
      # @emit('change')
