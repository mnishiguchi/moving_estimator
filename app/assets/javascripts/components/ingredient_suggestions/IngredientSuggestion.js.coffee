# The sub-component <IngredientSuggestion/>

@IngredientSuggestion = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  getInitialState: ->
    saved_value: @props.ingredient.name
    value:       @props.ingredient.name
    changed:     false
    updated:     false

  handleChange: ->
    input = @refs.input.getValue()
    if input is @state.saved_value
      @setState(value: input, changed: false, updated: false)
    else
      @setState(value: input, changed: true, updated: false)

  handleUpdate: (e) ->
    e.preventDefault()
    input = @refs.input.getValue()
    @getFlux().actions.updateIngredient(@props.ingredient, input)
    @setState(changed: false, updated: true, saved_value: input)

  handleDelete: (e) ->
    e.preventDefault()
    if confirm("Delete " + @state.saved_value + "?")
      @getFlux().actions.deleteIngredient(@props.ingredient)

  handleCancelChange: (e) ->
    e.preventDefault()
    @setState(value: @state.saved_value, changed: false)

  render: ->
    Button = ReactBootstrap.Button
    Input = ReactBootstrap.Input

    delete_button =
      <Button onClick={@handleDelete}>
        <i className="fa fa-times"></i>
      </Button>

    update_button =
      <div>
        <a onClick={@handleUpdate}      >Update</a>
        &nbsp; | &nbsp;
        <a onClick={@handleCancelChange}>Cancel</a>
      </div>

    type = if @state.changed
             'warning'
           else if @state.updated
             'success'

    <form>
      <Input type='text'
             onChange={@handleChange}
             ref='input'
             value={@state.value}
             buttonBefore={ delete_button }
             addonAfter={update_button if @state.changed}
             bsStyle={type}/>
    </form>
