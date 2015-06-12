@initTodoList = (options) ->
  flux = Fluxxor.getTodosFlux(options)

  # The main React component (<TodoList/>)

  @TodoList = React.createClass
    mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("TodoStore")]

    # getInitialState: ->
    #   new_todo_text: ""

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    render: ->

      todos = for todo in @state.todos
                <Todo todo={todo}
                      key={todo.id}
                      flux={flux} />

      <div className="well">
        <TodoNavigation todo={todos}
                        flux={flux} />
        { todos }
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist"))
    React.render <TodoList flux={flux} />, mountNode
