@initTodoList = (options) ->
  flux = Fluxxor.initTodosFlux(options)

  # The main React component (<TodoList/>)

  @TodoList = React.createClass
    mixins: [ Fluxxor.FluxMixin(React),
              Fluxxor.StoreWatchMixin("TodoStore") ]

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
        # @getFlux().actions.fetchTodos({})
        @setState(newTodoText: "")

    handleClearCompleted: (e) ->
      e.preventDefault()
      todos_wrapper = @props.flux.store('TodoStore').getState().todos
      if confirm("Clear all the completed items?")
        for id, todo of todos_wrapper
          @getFlux().actions.deleteTodo(id) if todo.completed

    render: ->

      form =
        <form onSubmit={ @onSubmitForm }>
          <div className="form-group">
            <input type="text"
                   placeholder="New Todo"
                   value={ @state.newTodoText }
                   onChange={ @onChangeAddTodoText }
                   className="form-control" />
          </div>
          <div className="form-group">
            <input type="submit"
                   value="Add Todo"
                   className="btn btn-success"/>
          </div>
        </form>

      Navbar  = ReactBootstrap.Navbar
      Nav     = ReactBootstrap.Nav
      NavItem = ReactBootstrap.NavItem
      ButtonToolbar = ReactBootstrap.ButtonToolbar
      ButtonGroup = ReactBootstrap.ButtonGroup
      Button = ReactBootstrap.Button

      navigation =
        <Navbar>
          1 item left
          <ButtonGroup>
            <Button>Left</Button>
            <Button>Middle</Button>
            <Button>Right</Button>
          </ButtonGroup>
          <Button onClick={ @handleClearCompleted }>Clear completed</Button>
        </Navbar>

      todos = for id, todo of @state.todos
                <Todo todo={ todo }
                      key={ id }
                      flux={ flux } />

      <div className="well">
        { form }

        { navigation }

        { todos }
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist"))
    React.render <TodoList flux={ flux } />, mountNode
