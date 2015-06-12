# The sub-component <Navigation />

@TodoNavigation = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

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
      <Button>Clear completed</Button>
    </Navbar>
