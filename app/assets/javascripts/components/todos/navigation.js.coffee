# Defining a todo item

@Navigation = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  # /   %nav.navbar.navbar-default
  # /     .container-fluid
  # /       .navbar-header
  # /         %a.navbar-brand Todos
  # /         %p.navbar-text
  # /           = pluralize(current_user.todos.count, "item")
  # /           left
  # /       .navbar-left
  # /         .btn-group.navbar-btn{ role:"group" }
  # /           %button.btn.btn-default{ type:"button" } All
  # /           %button.btn.btn-default{ type:"button" } Active
  # /           %button.btn.btn-default{ type:"button" } Completed
  # /       .navbar-right
  # /         .btn-group.navbar-btn{ role:"group" }
  # /           %button.btn.btn-default{ type:"button" } Clear completed
