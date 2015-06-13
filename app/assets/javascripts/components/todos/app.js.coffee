@initTodoList = (options) ->
  flux = Fluxxor.todosFlux(options)

  # The main React component (<TodoList/>)

  @TodoList = React.createClass
    mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("TodoStore")]

    getInitialState: ->
      new_todo_text: ""

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    onChangeAddTodoText: (e) ->
      @setState(newTodoText: e.target.value)

    onSubmitForm: (e) ->
      e.preventDefault()
      if @state.newTodoText.trim()
        @getFlux().actions.addTodo(@state.newTodoText)
        @getFlux().actions.fetchTodos({})
        @setState(newTodoText: "")

    render: ->

      form =
        <form onSubmit={@onSubmitForm}>
          <div className="form-group">
            <input type="text"
                   placeholder="New Todo"
                   value={@state.newTodoText}
                   onChange={@onChangeAddTodoText}
                   className="form-control" />
          </div>
          <div className="form-group">
            <input type="submit"
                   value="Add Todo"
                   className="btn btn-success"/>
          </div>
        </form>

      todos = for id, todo of @state.todos
                <Todo todo={todo}
                      key={id}
                      flux={flux} />

      <div className="well">
        { form }

        <TodoNavigation todo={ todos }
                        flux={ flux } />
        { todos }
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist"))
    React.render <TodoList flux={ flux } />, mountNode
