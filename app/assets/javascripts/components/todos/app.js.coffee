@initTodoList = (options) ->
  flux = Fluxxor.todosFlux(options)

  # The main React component (<TodoList/>)

  @TodoList = React.createClass
    mixins: [Fluxxor.FluxMixin(React), Fluxxor.StoreWatchMixin("TodoStore")]

    # getInitialState: ->
    #   new_todo_text: ""

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    render: ->

      todos = for id, todo of @state.todos
                <Todo todo={todo}
                      key={id}
                      flux={flux} />

      <div className="well">
        <TodoNavigation todo={ todos }
                        flux={ flux } />
        { todos }
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist"))
    React.render <TodoList flux={ flux } />, mountNode
