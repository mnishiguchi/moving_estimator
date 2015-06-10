# The sub-component <IngredientSuggestion/>

@IngredientSuggestion = React.createClass
  mixins: [Fluxxor.FluxMixin(React)]

  getInitialState: ->
    value:   @props.ingredient.name
    changed: false
    updated: false

  handleChange: ->
    input = @refs.input.getValue()
    original_name = @props.ingredient.name
    if input is original_name
    then @setState(changed: false)
    else @setState(changed: true, value: input)

  handleUpdate: (e) ->
    e.preventDefault()
    input = @refs.input.getValue()
    @getFlux().actions.updateIngredient(@props.ingredient, input)
    @setState(changed: false, updated: true)

  handleDelete: (e) ->
    e.preventDefault()
    if confirm("Delete " + @props.ingredient.name + "?")
      @getFlux().actions.deleteIngredient(@props.ingredient)

  handleCancelChange: (e) ->
    e.preventDefault()
    original_name = @props.ingredient.name
    @setState(changed: false, value: original_name)

  render: ->
    ButtonToolbar = ReactBootstrap.ButtonToolbar
    Button = ReactBootstrap.Button
    Input = ReactBootstrap.Input

    delete_button =
      <Button onClick={@handleDelete}>
        <i className="fa fa-times"></i>
      </Button>

    update_button =
      <div>
        <a onClick={@handleUpdate}       >Update</a>
        &nbsp; | &nbsp;
        <a onClick={@handleCancelChange} >Cancel</a>
      </div>

    <form>
      <Input type='text'
             onChange={@handleChange}
             ref='input'
             value={@state.value}
             buttonBefore={ delete_button }
             addonAfter={update_button if @state.changed}/>
    </form>
