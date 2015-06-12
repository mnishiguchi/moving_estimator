# The sub-component <TodoItem />

@Todo = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  getInitialState: ->
    saved_value: @props.todo.content
    value:       @props.todo.content
    completed:   @props.todo.completed
    changed:     false
    updated:     false

  handleToggleCompleted: (e) ->
    e.preventDefault()
    toggled_completion = not @state.completed
    @getFlux().actions.toggleTodo(@props.todo, toggled_completion)
    @setState(completed: toggled_completion)

  handleChange: ->
    input = @refs.input.getValue()
    if input is @state.saved_value
      @setState(value: input, changed: false, updated: false)
    else
      @setState(value: input, changed: true, updated: false)

  handleUpdate: (e) ->
    e.preventDefault()
    input = @refs.input.getValue()
    @getFlux().actions.updateTodo(@props.todo, input)
    @setState(changed: false, updated: true, saved_value: input)

  handleCancelChange: (e) ->
    e.preventDefault()
    @setState(value: @state.saved_value, changed: false)

  render: ->

    Button = ReactBootstrap.Button
    Input  = ReactBootstrap.Input
    is_checked = if @state.completed then "fa fa-check-square-o" else "fa fa-square-o"

    checkbox =
        <i className={ is_checked }
            onClick={ @handleToggleCompleted }></i>

    update_button =
      <div>
        <a onClick={ @handleUpdate }>Update</a>
        &nbsp; | &nbsp;
        <a onClick={ @handleCancelChange }>Cancel</a>
      </div>

    type = if @state.changed
             'warning'
           else if @state.updated
             'success'

    <form>
      <Input type='text'
             onChange={ @handleChange }
             ref='input'
             value={ @state.value }
             addonBefore={ checkbox }
             addonAfter={ update_button if @state.changed }
             bsStyle={ type } />
    </form>
