# Invoked in a Rails template with JSON data passed in.
# Initializes the todolist component with the provided options.

@initTodoList = (options) ->

  # Instantiates the flux.

  flux = todolistFlux.init(options)
  constants = todolistFlux.constants

  # The controller(main) component (<TodoList/>)

  TodoList = React.createClass
    mixins: [ Fluxxor.FluxMixin(React),
              Fluxxor.StoreWatchMixin("TodoStore") ]

    getInitialState: ->
      newTodoText: ""
      filterMode: 1

    getStateFromFlux: ->
      flux = @getFlux()
      flux.store('TodoStore').getState()

    handleChangeAddTodoText: (e) ->
      @setState(newTodoText: e.target.value)

    handleSubmitForm: (e) ->
      e.preventDefault()
      if @state.newTodoText.trim()
        @getFlux().actions.addTodo(@state.newTodoText)
        @setState(newTodoText: "")

    handleClearCompleted: (e) ->
      e.preventDefault()
      todos_wrapper = @getStateFromFlux().todos
      if confirm("Clear all the completed items?")
        for id, todo of todos_wrapper
          @getFlux().actions.deleteTodo(id) if todo.completed

    handleSelectTodoNav: (selectedKey) ->
      console.log "selectedKey: " + selectedKey
      if selectedKey is 1
        @getFlux().actions.filterAll()
        @setState(filterMode: 1)
      else if selectedKey is 2
        @getFlux().actions.filterNotDone()
        @setState(filterMode: 2)
      else if selectedKey is 3
        @getFlux().actions.filterCompleted()
        @setState(filterMode: 3)

    render: ->

      # Bootstrap components
      Nav = ReactBootstrap.Nav
      NavItem = ReactBootstrap.NavItem
      ButtonGroup = ReactBootstrap.ButtonGroup
      Button = ReactBootstrap.Button
      Input  = ReactBootstrap.Input

      add_button =
        <Button type="submit" bsStyle="primary">Add Todo</Button>

      add_form =
        <form onSubmit={ @handleSubmitForm } id="add_form">
          <Input type='text'
                 onChange={ @handleChangeAddTodoText }
                 placeholder="New Todo"
                 ref='input'
                 value={ @state.newTodoText }
                 buttonAfter={ add_button } />
        </form>

      navigation =
        <nav id="todo_navbar" >
          <Button onClick={ @handleClearCompleted } className="pull-right">Clear completed</Button>
          <Nav bsStyle='pills' activeKey={ @state.filterMode } onSelect={ @handleSelectTodoNav }>
            <NavItem eventKey={1}>All</NavItem>
            <NavItem eventKey={2}>Active</NavItem>
            <NavItem eventKey={3}>Completed</NavItem>
          </Nav>
        </nav>

      createTodoItems = (todos) ->
        for id, todo of todos
          <TodoItem todo={ todo } key={ id } />

      <div id="todolist_wrapper">
        { add_form }
        { navigation }
        <div id="todo_items_wrapper">
          { createTodoItems(@state.todos) }
        </div>
      </div>

  # Rendering the whole component to the mount node

  if (mountNode = document.getElementById("react_todolist"))
    React.render <TodoList flux={ flux } />, mountNode
