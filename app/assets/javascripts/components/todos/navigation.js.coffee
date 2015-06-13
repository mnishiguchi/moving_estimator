# The sub-component <Navigation />

@TodoNavigation = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  handleClearCompleted: (e) ->
    e.preventDefault()
    todos_wrapper = @props.flux.store('TodoStore').getState().todos
    if confirm("Clear all the completed items?")
      for id, todo of todos_wrapper
        @getFlux().actions.deleteTodo(id) if todo.completed

  render: ->
    Navbar  = ReactBootstrap.Navbar
    Nav     = ReactBootstrap.Nav
    NavItem = ReactBootstrap.NavItem
    ButtonToolbar = ReactBootstrap.ButtonToolbar
    ButtonGroup = ReactBootstrap.ButtonGroup
    Button = ReactBootstrap.Button

    <Navbar>
      1 item left
      <ButtonGroup>
        <Button>Left</Button>
        <Button>Middle</Button>
        <Button>Right</Button>
      </ButtonGroup>
      <Button onClick={ @handleClearCompleted }>Clear completed</Button>
    </Navbar>
