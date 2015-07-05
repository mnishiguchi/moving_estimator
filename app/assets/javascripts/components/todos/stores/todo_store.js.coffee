constants = require('../constants/todo_constants')

TodoStore = Fluxxor.createStore

  initialize: (todos) ->
    @todos = todos || {}
    console.log todos

    @bindActions(constants.ADD_TODO,    @onAddTodo,
                 constants.TOGGLE_TODO, @onToggleTodo,
                 constants.UPDATE_TODO, @onUpdateTodo,
                 constants.DELETE_TODO, @onDeleteTodo )

  getState: ->
    todos: @todos

  onAddTodo: (payload) ->
    # Update UI
    new_todo = payload.new_todo
    @todos.push(new_todo)
    @emit('change')

  onToggleTodo: (payload) ->
    # Update UI
    index = @todos.indexOf(payload.todo)
    @todos[index].completed = payload.completed
    @emit('change')

  onUpdateTodo: (payload) ->
    # Update UI
    index = @todos.indexOf(payload.todo)
    @todos[index].content = payload.new_content
    @emit('change')

  onDeleteTodo: (payload) ->
    # Update UI
    index = @todos.indexOf(payload.todo)
    @todos.splice(index, 1)  # Deletes the todo.
    @emit('change')

module.exports = TodoStore
